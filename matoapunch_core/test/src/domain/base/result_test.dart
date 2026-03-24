import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('Result', () {
    test('data exposes the success branch', () {
      const result = Result.data(42);

      expect(
        result.when(
          data: (value) => value,
          error: (_, _) => -1,
        ),
        42,
      );
    });

    test('error exposes the error branch', () {
      final exception = Exception('failed');
      final result = Result<int>.error(error: exception);

      expect(
        result.when(
          data: (_) => 'data',
          error: (error, _) => error,
        ),
        same(exception),
      );
    });

    test('toOption converts data into some', () {
      final option = const Result.data('value').toOption();

      expect(option.isSome(), isTrue);
      expect(option.getOrElse(() => 'fallback'), 'value');
    });

    test('toOption converts error into none', () {
      final option = Result<String>.error(
        error: Exception('failed'),
      ).toOption();

      expect(option.isNone(), isTrue);
      expect(option.getOrElse(() => 'fallback'), 'fallback');
    });
  });
}
