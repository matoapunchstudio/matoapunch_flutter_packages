# matoapunch_rbac

A lightweight RBAC package for Flutter and Dart.

It provides:
- immutable RBAC state through `MatoapunchRbac`
- domain entities for `Permission` and `Role`
- JSON and base64 permission encoding helpers
- permission check extensions for roles and permission-carrying objects
- a simple `RbacGuard` widget for protecting UI

This package is designed to stay small and predictable. `Permission.name` is
the stable identity used for comparisons and permission checks.

## Install

```sh
dart pub add matoapunch_rbac
```

## Public Imports

Use the root import for the full package:

```dart
import 'package:matoapunch_rbac/matoapunch_rbac.dart';
```

Or import by area:

```dart
import 'package:matoapunch_rbac/domain.dart';
import 'package:matoapunch_rbac/extensions.dart';
import 'package:matoapunch_rbac/utils.dart';
import 'package:matoapunch_rbac/widgets.dart';
```

## Core Types

### Permission

Represents a single access capability.

```dart
const permission = Permission(
  name: 'user.read',
  displayName: 'Read User',
);
```

### Role

Represents a named group of permissions.

```dart
const role = Role(
  name: 'admin',
  displayName: 'Administrator',
  permissions: [
    Permission(name: 'user.read', displayName: 'Read User'),
    Permission(name: 'user.write', displayName: 'Write User'),
  ],
);
```

### MatoapunchRbac

Stores an immutable permission set and exposes permission checks.

```dart
final rbac = MatoapunchRbac(
  permissions: const [
    Permission(name: 'user.read', displayName: 'Read User'),
  ],
);

final canRead = rbac.hasPermissionByName('user.read');
final canDelete = rbac.hasPermissionByName('user.delete');
```

You can also build RBAC state from roles:

```dart
final rbacFromRole = MatoapunchRbac.fromRole(role);
final rbacFromRoles = MatoapunchRbac.fromAnyRole([role]);
```

## JSON Format

`toJson()` writes snake_case fields:

```json
{
  "name": "user.read",
  "display_name": "Read User"
}
```

The package keeps backward compatibility when reading data:
- writes `display_name`
- reads both `display_name` and legacy `displayName`

This is important for previously stored permission payloads and role JSON.

## Encode And Decode Permissions

Permissions can be encoded into base64 for transport or storage.

```dart
final encoded = RbacCodec.encodePermissions(
  const [
    Permission(name: 'user.read', displayName: 'Read User'),
  ],
);

final decoded = RbacCodec.decodePermissions(encoded);
```

Or use extensions:

```dart
final encoded = const [
  Permission(name: 'user.read', displayName: 'Read User'),
].toBase64();

final decoded = encoded.toPermissions();
```

## Check Permissions With Extensions

### Role checks

```dart
final canRead = role.hasPermissionByName('user.read');
final canAny = role.hasAnyPermissionsByName([
  'user.delete',
  'user.write',
]);
```

### List<Role> checks

```dart
final roles = [role];

final canWrite = roles.hasPermissionByName('user.write');
```

### ShouldHavePermission checks

Any object implementing `ShouldHavePermission` can reuse the same helpers.

```dart
class MenuAccess implements ShouldHavePermission {
  const MenuAccess(this.permissions);

  @override
  final List<Permission> permissions;
}

final access = MenuAccess(
  const [
    Permission(name: 'menu.reports', displayName: 'Reports Menu'),
  ],
);

final canOpenReports = access.hasPermissionByName('menu.reports');
```

## Protect Widgets

Use `RbacGuard` to show or hide UI based on granted permissions.

```dart
RbacGuard(
  rbac: rbac,
  permissions: const ['user.read'],
  child: const Text('Allowed'),
)
```

By default it grants access when any required permission matches.

Require all permissions:

```dart
RbacGuard(
  rbac: rbac,
  permissions: const ['user.read', 'user.write'],
  match: RbacGuardMatch.all,
  child: const Text('Allowed'),
)
```

Use convenience constructors when you have permissions or roles directly:

```dart
RbacGuard.fromPermissions(
  grantedPermissions: const [
    Permission(name: 'user.read', displayName: 'Read User'),
  ],
  permissions: const ['user.read'],
  child: const Text('Allowed'),
)

RbacGuard.fromRole(
  role: role,
  permissions: const ['user.read'],
  child: const Text('Allowed'),
)

RbacGuard.fromRoles(
  roles: [role],
  permissions: const ['user.read'],
  child: const Text('Allowed'),
)
```

When access is denied, the default fallback is `SizedBox.shrink()`.

## Recommended Usage Pattern

Use these rules consistently:
- use `name` as the stable identifier
- keep display labels in `displayName`
- serialize outward with snake_case
- accept both snake_case and legacy camelCase when reading stored data
- prefer `MatoapunchRbac` for checks when you already have RBAC state
- use extensions for ergonomic checks on `Role`, `List<Role>`, and `ShouldHavePermission`

## Example Flow

```dart
final role = Role.fromJson(const {
  'name': 'admin',
  'display_name': 'Administrator',
  'permissions': [
    {
      'name': 'user.read',
      'display_name': 'Read User',
    },
  ],
});

final rbac = MatoapunchRbac.fromRole(role);

if (rbac.hasPermissionByName('user.read')) {
  // allow access
}

final encoded = rbac.encodePermissions();
final restored = MatoapunchRbac.fromEncodedPermissions(encoded);
```

## Development

Run analyzer:

```sh
flutter analyze
```

Run tests:

```sh
flutter test
```
