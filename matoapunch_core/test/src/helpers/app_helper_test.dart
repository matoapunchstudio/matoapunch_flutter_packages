import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('app helpers', () {
    test('safeCall returns data when the callback succeeds', () async {
      final result = await safeCall(() async => 'done');

      expect(
        result.when(
          data: (value) => value,
          error: (_, _) => 'error',
        ),
        'done',
      );
    });

    test(
      'safeCall returns error when the callback throws an exception',
      () async {
        final result = await safeCall<String>(() async {
          throw Exception('failed');
        });

        expect(
          result.when(
            data: (_) => false,
            error: (error, _) => error is Exception,
          ),
          isTrue,
        );
      },
    );

    test('safeCallSync returns data when the callback succeeds', () {
      final result = safeCallSync(() => 10);

      expect(
        result.when(
          data: (value) => value,
          error: (_, _) => -1,
        ),
        10,
      );
    });

    test(
      'safeCallSync returns error when the callback throws an exception',
      () {
        final result = safeCallSync<int>(() {
          throw Exception('failed');
        });

        expect(
          result.when(
            data: (_) => false,
            error: (error, _) => error is Exception,
          ),
          isTrue,
        );
      },
    );

    test('helper constructors create the expected wrappers', () {
      expect(ok('value'), isA<Result<String>>());
      expect(err<String>(Exception('failed')), isA<Result<String>>());
      expect(some(1), isA<Option<int>>());
      expect(none<int>(), isA<Option<int>>());
      expect(left<String, int>('invalid'), isA<Either<String, int>>());
      expect(right<String, int>(200), isA<Either<String, int>>());
    });
  });
}
