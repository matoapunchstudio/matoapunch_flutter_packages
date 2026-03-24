import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_http/matoapunch_http.dart';

void main() {
  group('AuthHttpClient', () {
    test('creates client with AuthBearerInterceptor', () {
      final client = AuthHttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
      );

      expect(client, isNotNull);
      expect(client.interceptors, isNotEmpty);

      final hasAuthInterceptor = client.interceptors.any(
        (i) => i is AuthBearerInterceptor,
      );
      expect(hasAuthInterceptor, isTrue);
    });

    test('creates client with HttpErrorInterceptor', () {
      final client = AuthHttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
      );

      final hasErrorInterceptor = client.interceptors.any(
        (i) => i is HttpErrorInterceptor,
      );
      expect(hasErrorInterceptor, isTrue);
    });

    test('creates client with custom token key', () {
      final client = AuthHttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
        tokenKey: 'custom_token',
      );

      final authInterceptor =
          client.interceptors.firstWhere(
                (i) => i is AuthBearerInterceptor,
              )
              as AuthBearerInterceptor;

      expect(authInterceptor.tokenKey, equals('custom_token'));
    });

    test('creates client with refresh callback', () {
      Future<String?> refreshToken() async => 'new-token';

      final client = AuthHttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
        onRefreshToken: refreshToken,
      );

      final authInterceptor =
          client.interceptors.firstWhere(
                (i) => i is AuthBearerInterceptor,
              )
              as AuthBearerInterceptor;

      expect(authInterceptor.onRefreshToken, isNotNull);
    });

    test('creates client with additional interceptors', () {
      final customInterceptor = _CustomInterceptor();
      final client = AuthHttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
        interceptors: [customInterceptor],
      );

      expect(client.interceptors.length, equals(3));
      expect(client.interceptors.contains(customInterceptor), isTrue);
    });

    test('creates client with converter', () {
      const converter = JsonConverter();
      final client = AuthHttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
        converter: converter,
      );

      expect(client.converter, equals(converter));
    });
  });
}

class _CustomInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    return chain.proceed(chain.request);
  }
}
