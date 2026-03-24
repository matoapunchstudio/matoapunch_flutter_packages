// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('MatoapunchCore', () {
    test('can be instantiated', () {
      expect(MatoapunchCore(), isNotNull);
    });

    test('exports the core public API', () {
      expect(ok('value'), isA<Result<String>>());
      expect(some(1), isA<Option<int>>());
      expect(left<String, int>('error'), isA<Either<String, int>>());
      expect(_TestUseCase(), isA<AppUseCase<String, int>>());
    });
  });
}

class _TestUseCase extends AppUseCase<String, int> {
  @override
  Future<Result<String>> call(int params) async {
    return ok('user-$params');
  }
}
