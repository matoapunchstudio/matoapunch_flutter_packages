import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_core/matoapunch_core.dart';

void main() {
  group('Option', () {
    test('some returns the stored value from getOrElse', () {
      const option = Option.some('token');

      expect(option.getOrElse(() => 'guest'), 'token');
      expect(option.isSome(), isTrue);
      expect(option.isNone(), isFalse);
    });

    test('none returns the fallback from getOrElse', () {
      const option = Option<String>.none();

      expect(option.getOrElse(() => 'guest'), 'guest');
      expect(option.isSome(), isFalse);
      expect(option.isNone(), isTrue);
    });
  });
}
