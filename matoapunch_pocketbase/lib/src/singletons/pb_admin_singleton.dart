import 'package:matoapunch_pocketbase/src/singletons/_pb_auth_client.dart';

/// Manages the authenticated PocketBase client for admin users.
class PbAdminSingleton extends PbAuthClient {
  /// Returns the shared admin singleton instance.
  factory PbAdminSingleton() => _instance;

  PbAdminSingleton._();

  static final _instance = PbAdminSingleton._();

  @override
  String get clientName => 'PbAdminSingleton';

  @override
  String get collectionName => '_superusers';

  @override
  String get tokenKey => 'pb_admin_token';

  @override
  String get logLabel => 'ADMIN';
}
