import 'package:chopper/chopper.dart';
import 'package:matoapunch_http/src/interceptors/auth_bearer_interceptor.dart';
import 'package:matoapunch_http/src/interceptors/http_error_interceptor.dart';

/// Creates a [ChopperClient] with authentication.
///
/// Includes [AuthBearerInterceptor] for Bearer token injection
/// and [HttpErrorInterceptor] for consistent error handling.
class AuthHttpClient {
  /// Creates a [ChopperClient] configured for authenticated requests.
  ///
  /// [baseUrl] - The base URL for the API.
  /// [tokenKey] - SharedPreferences key for the bearer token.
  /// Defaults to `'token'`.
  /// [onRefreshToken] - Optional callback for token refresh on 401 responses.
  /// [services] - Optional list of Chopper services to register.
  /// [converter] - Optional converter for request/response bodies.
  /// [interceptors] - Optional additional interceptors.
  static ChopperClient create({
    required Uri baseUrl,
    String tokenKey = 'token',
    Future<String?> Function()? onRefreshToken,
    List<ChopperService>? services,
    Converter? converter,
    List<Interceptor>? interceptors,
  }) {
    return ChopperClient(
      baseUrl: baseUrl,
      services: services,
      converter: converter,
      interceptors: [
        AuthBearerInterceptor(
          tokenKey: tokenKey,
          onRefreshToken: onRefreshToken,
        ),
        HttpErrorInterceptor(),
        ...?interceptors,
      ],
    );
  }
}
