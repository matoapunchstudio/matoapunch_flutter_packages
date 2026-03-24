import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('AppUseCase', () {
    test('returns a result from the implemented call contract', () async {
      final useCase = _FormatNameUseCase();

      final result = await useCase(7);

      expect(
        result.when(
          data: (value) => value,
          error: (_, _) => 'error',
        ),
        'user-7',
      );
    });
  });
}

class _FormatNameUseCase extends AppUseCase<String, int> {
  @override
  Future<Result<String>> call(int params) async {
    return ok('user-$params');
  }
}
