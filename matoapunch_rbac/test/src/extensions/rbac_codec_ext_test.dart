// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_rbac/src/domain/entities/permission.dart';
import 'package:matoapunch_rbac/src/extensions/rbac_codec_ext.dart';

void main() {
  group('RbacCodec extensions', () {
    test('encodes permissions from list extension', () {
      final permissions = [
        Permission(name: 'user.read', displayName: 'Read User'),
        Permission(name: 'user.write', displayName: 'Write User'),
      ];

      final encoded = permissions.toBase64();

      expect(encoded, isNotEmpty);
    });

    test('decodes permissions from string extension', () {
      final permissions = [
        Permission(name: 'user.read', displayName: 'Read User'),
        Permission(name: 'user.write', displayName: 'Write User'),
      ];

      final encoded = permissions.toBase64();
      final decoded = encoded.toPermissions();

      expect(decoded, hasLength(2));
      expect(decoded.first.name, 'user.read');
      expect(decoded.first.displayName, 'Read User');
      expect(decoded.last.name, 'user.write');
      expect(decoded.last.displayName, 'Write User');
    });
  });
}
