/// Internal error codes for HTTP failures.
///
/// These codes classify the type of failure beyond HTTP status codes.
enum HttpErrorCode {
  /// Generic HTTP error code.
  ///
  /// Used when no more specific error code applies.
  generic(1100),

  /// Socket exception error code.
  ///
  /// Indicates a network-level socket failure.
  socket(1101),

  /// TLS handshake error code.
  ///
  /// Indicates a secure connection establishment failure.
  handshake(1102),

  /// Request timeout error code.
  ///
  /// Indicates the request exceeded its configured timeout.
  timeout(1103)
  ;

  const HttpErrorCode(this.code);

  /// The numeric error code.
  final num code;
}
