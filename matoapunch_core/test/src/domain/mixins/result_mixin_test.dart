import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('Result mixins', () {
    test('Future.toResult wraps a successful future', () async {
      final result = await Future.value('ready').toResult();

      expect(
        result.when(
          data: (value) => value,
          error: (_, _) => 'error',
        ),
        'ready',
      );
    });

    test('Future.toResult wraps exceptions as an error result', () async {
      final result = await Future<String>.error(
        Exception('failed'),
        StackTrace.empty,
      ).toResult();

      expect(
        result.when(
          data: (_) => false,
          error: (error, stackTrace) =>
              error is Exception && stackTrace == StackTrace.empty,
        ),
        isTrue,
      );
    });

    test('value.toResult wraps a plain value as success', () {
      final result = 7.toResult();

      expect(
        result.when(
          data: (value) => value,
          error: (_, _) => -1,
        ),
        7,
      );
    });
  });
}
