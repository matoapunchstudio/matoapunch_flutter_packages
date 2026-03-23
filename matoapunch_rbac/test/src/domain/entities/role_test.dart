// Not required for test files
// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:matoapunch_rbac/src/domain/entities/role.dart';

void main() {
  group('Role', () {
    test('supports value equality', () {
      expect(
        const Role(name: 'admin', displayName: 'Administrator'),
        const Role(name: 'admin', displayName: 'Administrator'),
      );
    });

    test('serializes to json', () {
      final role = Role(
        name: 'admin',
        displayName: 'Administrator',
      );

      expect(role.toJson(), const <String, dynamic>{
        'name': 'admin',
        'displayName': 'Administrator',
      });
    });

    test('deserializes from json', () {
      final role = Role.fromJson(const <String, dynamic>{
        'name': 'admin',
        'displayName': 'Administrator',
      });

      expect(role.name, 'admin');
      expect(role.displayName, 'Administrator');
    });
  });
}
