import 'package:equatable/equatable.dart';

/// A role that groups permissions under a stable identifier and label.
class Role extends Equatable {
  /// Creates a role definition used by the RBAC domain.
  const Role({required this.name, required this.displayName});

  /// Creates a role from its JSON representation.
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'] as String,
      displayName: json['displayName'] as String,
    );
  }

  /// The stable machine-readable role identifier.
  final String name;

  /// The human-readable role label intended for display.
  final String displayName;

  /// Converts this role into a JSON representation.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'displayName': displayName,
    };
  }

  @override
  List<Object> get props => [name];
}
