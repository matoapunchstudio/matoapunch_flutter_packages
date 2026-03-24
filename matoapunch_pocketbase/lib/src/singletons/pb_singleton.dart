import 'package:matoapunch_pocketbase/src/singletons/_pb_auth_client.dart';

/// Manages the authenticated PocketBase client for end users.
class PbSingleton extends PbAuthClient {
  /// Returns the shared user singleton instance.
  factory PbSingleton() => _instance;

  PbSingleton._();

  static final _instance = PbSingleton._();

  @override
  String get clientName => 'PbSingleton';

  @override
  String get collectionName => 'users';

  @override
  String get tokenKey => 'pb_token';

  @override
  String get logLabel => 'USER';

  /// Signs in with credentials supplied through compile-time environment vars.
  ///
  /// This is intended for local development only and requires both
  /// `PB_SIMULATED_EMAIL` and `PB_SIMULATED_PASSWORD` to be defined.
  Future<void> simulateLogin() async {
    const email = String.fromEnvironment('PB_SIMULATED_EMAIL');
    const password = String.fromEnvironment('PB_SIMULATED_PASSWORD');

    if (email.isEmpty || password.isEmpty) {
      throw StateError(
        'simulateLogin requires PB_SIMULATED_EMAIL and PB_SIMULATED_PASSWORD.',
      );
    }

    await loginWithEmailAndPassword(email, password);
  }
}
