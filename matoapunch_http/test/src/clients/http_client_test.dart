import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_http/matoapunch_http.dart';

void main() {
  group('HttpClient', () {
    test('creates client with HttpErrorInterceptor', () {
      final client = HttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
      );

      expect(client, isNotNull);
      expect(client.interceptors, isNotEmpty);

      final hasErrorInterceptor = client.interceptors.any(
        (i) => i is HttpErrorInterceptor,
      );
      expect(hasErrorInterceptor, isTrue);
    });

    test('creates client with additional interceptors', () {
      final customInterceptor = _CustomInterceptor();
      final client = HttpClient.create(
        baseUrl: Uri.parse('https://api.example.com'),
        interceptors: [customInterceptor],
      );

      expect(client.interceptors.length, equals(2));
      expect(client.interceptors.contains(customInterceptor), isTrue);
    });

    test('creates client with converter', () {
      const converter = JsonConverter();
      final client = HttpClient.create(
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
