import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_http/src/enums/http_error_code.dart';

void main() {
  group('HttpErrorCode', () {
    test('generic has code 1100', () {
      expect(HttpErrorCode.generic.code, 1100);
    });

    test('socket has code 1101', () {
      expect(HttpErrorCode.socket.code, 1101);
    });

    test('handshake has code 1102', () {
      expect(HttpErrorCode.handshake.code, 1102);
    });

    test('timeout has code 1103', () {
      expect(HttpErrorCode.timeout.code, 1103);
    });

    test('all error codes have unique values', () {
      final codes = HttpErrorCode.values.map((e) => e.code).toList();
      final uniqueCodes = codes.toSet();
      expect(codes.length, uniqueCodes.length);
    });

    test('values contains all expected enum values', () {
      expect(HttpErrorCode.values, [
        HttpErrorCode.generic,
        HttpErrorCode.socket,
        HttpErrorCode.handshake,
        HttpErrorCode.timeout,
      ]);
    });
  });
}
