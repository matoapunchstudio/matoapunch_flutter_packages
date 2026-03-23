import 'package:matoapunch_rbac/src/domain/entities/permission.dart';
import 'package:matoapunch_rbac/src/utils/rbac_codec.dart';

/// Adds base64 RBAC encoding helpers to a permission list.
extension PermissionListRbacCodecExt on List<Permission> {
  /// Encodes this permission list into a base64 string.
  String toBase64() => RbacCodec.encodePermissions(this);
}

/// Adds base64 RBAC decoding helpers to an encoded permission string.
extension PermissionStringRbacCodecExt on String {
  /// Decodes this base64 string into a permission list.
  List<Permission> toPermissions() => RbacCodec.decodePermissions(this);
}
