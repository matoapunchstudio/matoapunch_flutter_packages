import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matoapunch_http/matoapunch_http.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AuthBearerInterceptor interceptor;
  late Request request;

  setUp(() {
    interceptor = AuthBearerInterceptor();
    request = Request(
      'GET',
      Uri.parse('/users'),
      Uri.parse('https://example.com'),
    );

    SharedPreferences.setMockInitialValues({});
  });

  group('AuthBearerInterceptor', () {
    test('attaches Authorization header when token exists', () async {
      SharedPreferences.setMockInitialValues({'token': 'test-bearer-token'});

      final response = Response<String>(
        http.Response('ok', 200),
        'ok',
      );

      Request? capturedRequest;
      final result = await interceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            capturedRequest = req;
            return response;
          },
        ),
      );

      expect(result, same(response));
      expect(capturedRequest, isNotNull);
      expect(
        capturedRequest!.headers['Authorization'],
        equals('Bearer test-bearer-token'),
      );
    });

    test('passes request unchanged when no token found', () async {
      SharedPreferences.setMockInitialValues({});

      final response = Response<String>(
        http.Response('ok', 200),
        'ok',
      );

      Request? capturedRequest;
      final result = await interceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            capturedRequest = req;
            return response;
          },
        ),
      );

      expect(result, same(response));
      expect(capturedRequest, isNotNull);
      expect(capturedRequest!.headers.containsKey('Authorization'), isFalse);
    });

    test('passes request unchanged when token is empty', () async {
      SharedPreferences.setMockInitialValues({'token': ''});

      final response = Response<String>(
        http.Response('ok', 200),
        'ok',
      );

      Request? capturedRequest;
      final result = await interceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            capturedRequest = req;
            return response;
          },
        ),
      );

      expect(result, same(response));
      expect(capturedRequest, isNotNull);
      expect(capturedRequest!.headers.containsKey('Authorization'), isFalse);
    });

    test('uses custom token key when provided', () async {
      final customInterceptor = AuthBearerInterceptor(
        tokenKey: 'custom_token_key',
      );
      SharedPreferences.setMockInitialValues(
        {'custom_token_key': 'custom-bearer-token'},
      );

      final response = Response<String>(
        http.Response('ok', 200),
        'ok',
      );

      Request? capturedRequest;
      final result = await customInterceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            capturedRequest = req;
            return response;
          },
        ),
      );

      expect(result, same(response));
      expect(capturedRequest, isNotNull);
      expect(
        capturedRequest!.headers['Authorization'],
        equals('Bearer custom-bearer-token'),
      );
    });

    test('preserves existing headers', () async {
      SharedPreferences.setMockInitialValues({'token': 'test-token'});

      final requestWithHeaders = request.copyWith(
        headers: {'X-Custom-Header': 'custom-value'},
      );

      final response = Response<String>(
        http.Response('ok', 200),
        'ok',
      );

      Request? capturedRequest;
      await interceptor.intercept(
        _FakeChain<String>(
          request: requestWithHeaders,
          onProceed: (req) async {
            capturedRequest = req;
            return response;
          },
        ),
      );

      expect(capturedRequest, isNotNull);
      expect(
        capturedRequest!.headers['X-Custom-Header'],
        equals('custom-value'),
      );
      expect(
        capturedRequest!.headers['Authorization'],
        equals('Bearer test-token'),
      );
    });
  });

  group('AuthBearerInterceptor - Token Refresh', () {
    test('retries with new token on 401 when callback succeeds', () async {
      SharedPreferences.setMockInitialValues({'token': 'expired-token'});

      var callCount = 0;
      final refreshInterceptor = AuthBearerInterceptor(
        onRefreshToken: () async {
          return 'new-token';
        },
      );

      final requests = <Request>[];
      final result = await refreshInterceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            callCount++;
            requests.add(req);
            if (callCount == 1) {
              return Response<String>(
                http.Response('unauthorized', 401),
                null,
              );
            }
            return Response<String>(
              http.Response('ok', 200),
              'ok',
            );
          },
        ),
      );

      expect(result.statusCode, equals(200));
      expect(callCount, equals(2));
      expect(
        requests[0].headers['Authorization'],
        equals('Bearer expired-token'),
      );
      expect(requests[1].headers['Authorization'], equals('Bearer new-token'));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('token'), equals('new-token'));
    });

    test('returns 401 when callback returns null', () async {
      SharedPreferences.setMockInitialValues({'token': 'expired-token'});

      final refreshInterceptor = AuthBearerInterceptor(
        onRefreshToken: () async => null,
      );

      var callCount = 0;
      final result = await refreshInterceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            callCount++;
            return Response<String>(
              http.Response('unauthorized', 401),
              null,
            );
          },
        ),
      );

      expect(result.statusCode, equals(401));
      expect(callCount, equals(1));
    });

    test('returns 401 when callback returns empty string', () async {
      SharedPreferences.setMockInitialValues({'token': 'expired-token'});

      final refreshInterceptor = AuthBearerInterceptor(
        onRefreshToken: () async => '',
      );

      var callCount = 0;
      final result = await refreshInterceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            callCount++;
            return Response<String>(
              http.Response('unauthorized', 401),
              null,
            );
          },
        ),
      );

      expect(result.statusCode, equals(401));
      expect(callCount, equals(1));
    });

    test('does not refresh when callback is not provided', () async {
      SharedPreferences.setMockInitialValues({'token': 'expired-token'});

      var callCount = 0;
      final result = await interceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            callCount++;
            return Response<String>(
              http.Response('unauthorized', 401),
              null,
            );
          },
        ),
      );

      expect(result.statusCode, equals(401));
      expect(callCount, equals(1));
    });

    test('does not refresh on non-401 responses', () async {
      SharedPreferences.setMockInitialValues({'token': 'valid-token'});

      var refreshCalled = false;
      final refreshInterceptor = AuthBearerInterceptor(
        onRefreshToken: () async {
          refreshCalled = true;
          return 'new-token';
        },
      );

      final result = await refreshInterceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async => Response<String>(
            http.Response('ok', 200),
            'ok',
          ),
        ),
      );

      expect(result.statusCode, equals(200));
      expect(refreshCalled, isFalse);
    });

    test('prevents infinite refresh loop', () async {
      SharedPreferences.setMockInitialValues({'token': 'expired-token'});

      var callCount = 0;
      final refreshInterceptor = AuthBearerInterceptor(
        onRefreshToken: () async => 'new-token',
      );

      final result = await refreshInterceptor.intercept(
        _FakeChain<String>(
          request: request,
          onProceed: (req) async {
            callCount++;
            return Response<String>(
              http.Response('unauthorized', 401),
              null,
            );
          },
        ),
      );

      expect(result.statusCode, equals(401));
      expect(callCount, equals(2));
    });
  });
}

class _FakeChain<BodyType> implements Chain<BodyType> {
  _FakeChain({
    required this.request,
    required this.onProceed,
  });

  @override
  final Request request;

  final Future<Response<BodyType>> Function(Request request) onProceed;

  @override
  Future<Response<BodyType>> proceed(Request request) => onProceed(request);
}
