import 'dart:convert';

import 'package:matoapunch_rbac/src/domain/entities/permission.dart';

/// Encodes and decodes RBAC values for transport or storage.
class RbacCodec {
  /// Encodes a list of permissions into a base64 string.
  static String encodePermissions(List<Permission> permissions) {
    final jsonPermissions = permissions
        .map((permission) => permission.toJson())
        .toList(growable: false);

    final jsonString = jsonEncode(jsonPermissions);
    return base64Encode(utf8.encode(jsonString));
  }

  /// Decodes a base64 string into a list of permissions.
  static List<Permission> decodePermissions(String encodedPermissions) {
    final jsonString = utf8.decode(base64Decode(encodedPermissions));
    final decoded = jsonDecode(jsonString) as List<dynamic>;

    return decoded
        .map(
          (permission) {
            final permissionMap = permission as Map<String, dynamic>;
            return Permission.fromJson(permissionMap);
          },
        )
        .toList(growable: false);
  }
}
