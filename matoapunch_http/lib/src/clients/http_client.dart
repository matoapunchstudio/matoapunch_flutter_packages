import 'package:chopper/chopper.dart';
import 'package:matoapunch_http/src/interceptors/http_error_interceptor.dart';

/// Creates a [ChopperClient] without authentication.
///
/// Includes [HttpErrorInterceptor] for consistent error handling.
class HttpClient {
  /// Creates a [ChopperClient] configured for unauthenticated requests.
  ///
  /// [baseUrl] - The base URL for the API.
  /// [services] - Optional list of Chopper services to register.
  /// [converter] - Optional converter for request/response bodies.
  /// [interceptors] - Optional additional interceptors.
  static ChopperClient create({
    required Uri baseUrl,
    List<ChopperService>? services,
    Converter? converter,
    List<Interceptor>? interceptors,
  }) {
    return ChopperClient(
      baseUrl: baseUrl,
      services: services,
      converter: converter,
      interceptors: [
        HttpErrorInterceptor(),
        ...?interceptors,
      ],
    );
  }
}
