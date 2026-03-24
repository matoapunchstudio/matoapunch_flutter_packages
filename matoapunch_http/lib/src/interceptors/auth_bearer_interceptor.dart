import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Intercepts HTTP requests and attaches a Bearer token
/// from [SharedPreferences] as an Authorization header.
///
/// Optionally refreshes expired tokens on 401 responses
/// using [onRefreshToken] callback.
class AuthBearerInterceptor implements Interceptor {
  /// Creates an [AuthBearerInterceptor].
  ///
  /// [tokenKey] is the SharedPreferences key where the token is stored.
  /// Defaults to `'token'`.
  ///
  /// [onRefreshToken] is an optional callback that performs token refresh.
  /// It should return the new token string, or `null` if refresh fails.
  /// When provided, 401 responses trigger an automatic refresh and retry.
  AuthBearerInterceptor({
    this.tokenKey = 'token',
    this.onRefreshToken,
  });

  /// The SharedPreferences key used to store the bearer token.
  final String tokenKey;

  /// Optional callback that refreshes the token.
  ///
  /// Called when a 401 response is received.
  /// Returns the new token string, or `null` if refresh fails.
  final Future<String?> Function()? onRefreshToken;

  static const _retryHeader = 'X-Retry-After-Refresh';

  @override
  Future<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(tokenKey);

    if (token == null || token.isEmpty) {
      return chain.proceed(chain.request);
    }

    final authenticatedRequest = chain.request.copyWith(
      headers: {
        ...chain.request.headers,
        'Authorization': 'Bearer $token',
      },
    );

    final response = await chain.proceed(authenticatedRequest);

    if (response.statusCode == 401 &&
        onRefreshToken != null &&
        !authenticatedRequest.headers.containsKey(_retryHeader)) {
      final newToken = await onRefreshToken!();

      if (newToken != null && newToken.isNotEmpty) {
        await prefs.setString(tokenKey, newToken);

        final retryRequest = authenticatedRequest.copyWith(
          headers: {
            ...authenticatedRequest.headers,
            'Authorization': 'Bearer $newToken',
            _retryHeader: 'true',
          },
        );

        return chain.proceed(retryRequest);
      }
    }

    return response;
  }
}
