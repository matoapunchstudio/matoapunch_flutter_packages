import 'package:equatable/equatable.dart';

/// A permission that represents a single access capability in RBAC.
class Permission extends Equatable {
  /// Creates a permission definition used by the RBAC domain.
  const Permission({required this.name, required this.displayName});

  /// Creates a permission from its JSON representation.
  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
    );
  }

  /// The stable machine-readable permission identifier.
  final String name;

  /// The human-readable permission label intended for display.
  final String displayName;

  /// Converts this permission into a JSON representation.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'displayName': displayName,
    };
  }

  @override
  List<Object> get props => [name];
}
