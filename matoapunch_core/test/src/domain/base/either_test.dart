import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('Either', () {
    test('left resolves the left branch', () {
      const either = Either<String, int>.left('invalid');

      expect(
        either.when(
          left: (value) => value,
          right: (value) => '$value',
        ),
        'invalid',
      );
    });

    test('right resolves the right branch', () {
      const either = Either<String, int>.right(200);

      expect(
        either.when(
          left: (value) => value.length,
          right: (value) => value,
        ),
        200,
      );
    });

    group('toOption', () {
      test('returns none for left', () {
        const either = Either<String, int>.left('error');

        final option = either.toOption();

        expect(option.isNone(), isTrue);
        expect(option.isSome(), isFalse);
      });

      test('returns some for right', () {
        const either = Either<String, int>.right(42);

        final option = either.toOption();

        expect(option.isSome(), isTrue);
        expect(option.isNone(), isFalse);
        expect(
          option.getOrElse(() => -1),
          42,
        );
      });

      test('preserves right value in some', () {
        const either = Either<String, String>.right('success');

        final option = either.toOption();

        expect(
          option.getOrElse(() => 'fallback'),
          'success',
        );
      });
    });
  });
}
