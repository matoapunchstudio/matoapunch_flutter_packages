import 'package:matoapunch_rbac/src/domain/abstracts/should_have_permission.dart';
import 'package:matoapunch_rbac/src/domain/entities/permission.dart';
import 'package:matoapunch_rbac/src/domain/entities/role.dart';
import 'package:matoapunch_rbac/src/matoapunch_rbac.dart';

/// Adds RBAC permission check helpers to any permission-carrying object.
extension ShouldHavePermissionRbacCheckExt on ShouldHavePermission {
  /// Returns `true` when this object grants [permission].
  bool hasPermission(Permission permission) {
    return MatoapunchRbac(permissions: permissions).hasPermission(permission);
  }

  /// Returns `true` when this object grants [permissionName].
  bool hasPermissionByName(String permissionName) {
    return MatoapunchRbac(permissions: permissions).hasPermissionByName(
      permissionName,
    );
  }

  /// Returns `true` when this object grants any of [permissions].
  bool hasAnyPermissions(List<Permission> permissions) {
    return MatoapunchRbac(
      permissions: this.permissions,
    ).hasAnyPermissions(permissions);
  }

  /// Returns `true` when this object grants any of [permissionNames].
  bool hasAnyPermissionsByName(List<String> permissionNames) {
    return MatoapunchRbac(
      permissions: permissions,
    ).hasAnyPermissionsByName(permissionNames);
  }
}

/// Adds RBAC permission check helpers to a permission-carrying collection.
extension ShouldHavePermissionListRbacCheckExt on List<ShouldHavePermission> {
  /// Returns `true` when any object in this list grants [permission].
  bool hasPermission(Permission permission) {
    final permissions = expand(
      (item) => item.permissions,
    ).toList(growable: false);

    return MatoapunchRbac(permissions: permissions).hasPermission(permission);
  }

  /// Returns `true` when any object in this list grants [permissionName].
  bool hasPermissionByName(String permissionName) {
    final permissions = expand(
      (item) => item.permissions,
    ).toList(growable: false);

    return MatoapunchRbac(
      permissions: permissions,
    ).hasPermissionByName(permissionName);
  }

  /// Returns `true` when any object in this list grants any of [permissions].
  bool hasAnyPermissions(List<Permission> permissions) {
    final activePermissions = expand((item) => item.permissions).toList(
      growable: false,
    );

    return MatoapunchRbac(
      permissions: activePermissions,
    ).hasAnyPermissions(permissions);
  }

  /// Returns `true` when any object in this list grants any of
  /// [permissionNames].
  bool hasAnyPermissionsByName(List<String> permissionNames) {
    final permissions = expand(
      (item) => item.permissions,
    ).toList(growable: false);

    return MatoapunchRbac(
      permissions: permissions,
    ).hasAnyPermissionsByName(permissionNames);
  }
}

/// Adds RBAC permission check helpers to a role collection.
extension RoleListRbacCheckExt on List<Role> {
  /// Returns `true` when any role in this list grants [permission].
  bool hasPermission(Permission permission) {
    return MatoapunchRbac.fromAnyRole(this).hasPermission(permission);
  }

  /// Returns `true` when any role in this list grants [permissionName].
  bool hasPermissionByName(String permissionName) {
    return MatoapunchRbac.fromAnyRole(this).hasPermissionByName(permissionName);
  }

  /// Returns `true` when any role in this list grants any of [permissions].
  bool hasAnyPermissions(List<Permission> permissions) {
    return MatoapunchRbac.fromAnyRole(this).hasAnyPermissions(permissions);
  }

  /// Returns `true` when any role in this list grants any of [permissionNames].
  bool hasAnyPermissionsByName(List<String> permissionNames) {
    return MatoapunchRbac.fromAnyRole(this).hasAnyPermissionsByName(
      permissionNames,
    );
  }
}
