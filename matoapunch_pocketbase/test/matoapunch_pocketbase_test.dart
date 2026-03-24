// Legacy selector compatibility is intentionally verified in this file.

import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_pocketbase/matoapunch_pocketbase.dart';

void main() {
  group('matoapunch_pocketbase', () {
    test('returns the same singleton instance', () {
      expect(MatoapunchPocketbase(), same(MatoapunchPocketbase()));
      expect(MatoapunchPocketbase().user, same(PbSingleton()));
      expect(MatoapunchPocketbase().admin, same(PbAdminSingleton()));
    });

    test('throws a clear error for uninitialized explicit clients', () {
      expect(
        () => MatoapunchPocketbase().userClient,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('Call MatoapunchPocketbase().init() first'),
          ),
        ),
      );
      expect(
        () => MatoapunchPocketbase().adminClient,
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            contains('Call MatoapunchPocketbase().init() first'),
          ),
        ),
      );
    });
  });

  group('PbErrorMessage', () {
    test('parses non-string payload values safely', () {
      final error = PbErrorMessage.fromExceptionResponse('email', {
        'code': 400,
        'message': null,
      });

      expect(error.key, 'email');
      expect(error.code, '400');
      expect(error.message, 'Unknown error');
    });
  });
}
