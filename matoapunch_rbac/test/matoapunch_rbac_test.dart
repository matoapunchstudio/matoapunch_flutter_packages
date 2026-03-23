// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_rbac/matoapunch_rbac.dart';
import 'package:matoapunch_rbac/src/domain/entities/permission.dart';

void main() {
  group('MatoapunchRbac', () {
    test('can be instantiated', () {
      expect(MatoapunchRbac(), isNotNull);
    });

    test('checks permission by instance using permission name', () {
      final rbac = MatoapunchRbac(
        permissions: [
          Permission(name: 'user.read', displayName: 'Read User'),
        ],
      );

      expect(
        rbac.hasPermission(
          Permission(name: 'user.read', displayName: 'Read User Again'),
        ),
        isTrue,
      );
    });

    test('checks permission by name', () {
      final rbac = MatoapunchRbac(
        permissions: [
          Permission(name: 'user.read', displayName: 'Read User'),
        ],
      );

      expect(rbac.hasPermissionByName('user.read'), isTrue);
      expect(rbac.hasPermissionByName('user.write'), isFalse);
    });

    test('checks whether any permission exists', () {
      final rbac = MatoapunchRbac(
        permissions: [
          Permission(name: 'user.read', displayName: 'Read User'),
        ],
      );

      expect(
        rbac.hasAnyPermissions([
          Permission(name: 'user.write', displayName: 'Write User'),
          Permission(name: 'user.read', displayName: 'Read User'),
        ]),
        isTrue,
      );
    });

    test('checks whether any permission name exists', () {
      final rbac = MatoapunchRbac(
        permissions: [
          Permission(name: 'user.read', displayName: 'Read User'),
        ],
      );

      expect(
        rbac.hasAnyPermissionsByName(['user.write', 'user.read']),
        isTrue,
      );
      expect(
        rbac.hasAnyPermissionsByName(['user.write', 'user.delete']),
        isFalse,
      );
    });

    test('exposes permissions as an immutable list', () {
      final rbac = MatoapunchRbac(
        permissions: [
          Permission(name: 'user.read', displayName: 'Read User'),
        ],
      );

      expect(rbac.permissions, hasLength(1));
      expect(
        () => rbac.permissions.add(
          const Permission(name: 'user.write', displayName: 'Write User'),
        ),
        throwsUnsupportedError,
      );
    });

    test('encodes and decodes permissions through factories', () {
      final rbac = MatoapunchRbac(
        permissions: [
          Permission(name: 'user.read', displayName: 'Read User'),
          Permission(name: 'user.write', displayName: 'Write User'),
        ],
      );

      final encoded = rbac.encodePermissions();
      final decoded = MatoapunchRbac.fromEncodedPermissions(encoded);

      expect(decoded.permissions, rbac.permissions);
    });
  });
}
