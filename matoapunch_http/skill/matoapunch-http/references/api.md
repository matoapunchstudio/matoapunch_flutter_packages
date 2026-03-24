# API Reference

## Import

```dart
import 'package:matoapunch_http/matoapunch_http.dart';
```

## HttpClient

Creates a `ChopperClient` without authentication. Includes `HttpErrorInterceptor` by default.

```dart
final client = HttpClient.create(
  baseUrl: Uri.parse('https://api.example.com'),
  services: [MyService.create()],
  converter: JsonConverter(),
  interceptors: [/* additional interceptors */],
);
```

## AuthHttpClient

Creates a `ChopperClient` with authentication. Includes `AuthBearerInterceptor` and `HttpErrorInterceptor` by default.

```dart
final client = AuthHttpClient.create(
  baseUrl: Uri.parse('https://api.example.com'),
  tokenKey: 'token', // SharedPreferences key, defaults to 'token'
  onRefreshToken: () async => await refreshToken(), // Optional
  services: [MyService.create()],
  converter: JsonConverter(),
  interceptors: [/* additional interceptors */],
);
```

## AuthBearerInterceptor

Attaches a Bearer token from `shared_preferences` to requests. Optionally refreshes expired tokens on 401 responses.

```dart
final interceptor = AuthBearerInterceptor(
  tokenKey: 'token', // SharedPreferences key, defaults to 'token'
  onRefreshToken: () async {
    // Your refresh logic
    return 'new-token'; // Return null if refresh fails
  },
);
```

### Token Refresh Behavior

When `onRefreshToken` is provided and a 401 response is received:
1. The callback is invoked to get a new token.
2. If a new token is returned, it is saved to `shared_preferences` and the request is retried.
3. If `null` is returned, the original 401 response is passed through.
4. Infinite loops are prevented — each request is only refreshed once.

## HttpErrorInterceptor

Use `HttpErrorInterceptor` in a `ChopperClient` to normalize failures into `ResponseException`.

```dart
final client = ChopperClient(
  baseUrl: Uri.parse('https://api.example.com'),
  interceptors: const [
    HttpErrorInterceptor(),
  ],
);
```

## ResponseException

`ResponseException` exposes:

- `status` as `ConnectionResultStatus`
- `code` as the internal package error code
- `httpCode` as the HTTP status code when applicable, otherwise `null`
- `message` as the normalized error message
- `body` as the raw response body when available
- `stackTrace` when captured

```dart
try {
  await service.getProfile();
} on ResponseException catch (error) {
  print(error.status);
  print(error.httpCode);
  print(error.message);
}
```

## ConnectionResultStatus

Use `ConnectionResultStatus` to classify failures:

- `success`
- `timeout`
- `noInternet`
- `error`

## Error Mapping

`HttpErrorInterceptor` currently maps:

- non-2xx HTTP responses to `ResponseException` with `code == httpCode`
- `SocketException` to `noInternet` with code `1101`
- `HandshakeException` to `noInternet` with code `1102`
- `TimeoutException` to `timeout` with code `1103`
- transport failures to `httpCode == null`
- other exceptions to `error` with code `1100`
