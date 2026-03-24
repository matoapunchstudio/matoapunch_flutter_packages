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
  });
}
