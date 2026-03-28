import 'dart:developer';

import 'package:matoapunch_core/matoapunch_core.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared auth lifecycle for PocketBase user/admin clients.
abstract class PbAuthClient {
  static const _baseUrl = String.fromEnvironment('PB_BASE_URL');

  PocketBase? _pocketBase;
  AuthStore? _authStore;

  /// Name used in initialization errors.
  String get clientName;

  /// PocketBase auth collection for this client.
  String get collectionName;

  /// Shared preferences key for the persisted token.
  String get tokenKey;

  /// Label used in debug logs after a successful refresh.
  String get logLabel;

  /// Returns the current PocketBase client instance.
  PocketBase get pocketBase {
    final client = _pocketBase;
    if (client == null) {
      throw StateError(
        '$clientName is not initialized. '
        'Call MatoapunchPocketbase().init() first.',
      );
    }
    return client;
  }

  /// Restores persisted auth state and initializes the PocketBase client.
  Future<void> setup() async {
    if (_baseUrl.isEmpty) {
      throw StateError(
        'PB_BASE_URL environment variable is not set. '
        'Set it using --dart-define=PB_BASE_URL=<url> during build/run.',
      );
    }

    final token = await _getToken();
    if (token.isNotEmpty) {
      _authStore = AsyncAuthStore(
        initial: token,
        save: _saveToken,
        clear: _clearToken,
      );
    }

    _pocketBase = _createClient();

    if (pocketBase.authStore.isValid) {
      await refresh();
      _logCurrentUser();
    }
  }

  /// Refreshes the current auth session when a token is available.
  Future<void> refresh() async {
    final authRecord = await pocketBase
        .collection(collectionName)
        .authRefresh()
        .toResult();

    authRecord.when(
      data: (data) {
        _ensureAuthStore(data.token);
        _authStore!.save(data.token, data.record);
        _pocketBase = _createClient();
      },
      error: (e, s) {
        log('Failed to refresh $logLabel session: $e', stackTrace: s);
        _authStore?.clear();
        _pocketBase = _createClient();
      },
    );
  }

  /// Updates the auth store from a successful PocketBase auth response.
  RecordModel updateAuth(RecordAuth auth) {
    _ensureAuthStore(auth.token);
    _authStore!.save(auth.token, auth.record);
    _pocketBase = _createClient();
    return auth.record;
  }

  /// Signs in with email and password credentials.
  Future<RecordModel> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final login = await pocketBase
        .collection(collectionName)
        .authWithPassword(email, password);
    _ensureAuthStore(login.token);
    _authStore!.save(login.token, login.record);
    _pocketBase = _createClient();
    return login.record;
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
  }

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey) ?? '';
  }

  PocketBase _createClient() => PocketBase(_baseUrl, authStore: _authStore);

  void _ensureAuthStore(String token) {
    _authStore ??= AsyncAuthStore(
      initial: token,
      save: _saveToken,
      clear: _clearToken,
    );
  }

  void _logCurrentUser() {
    final user = pocketBase.authStore.record;
    if (user == null) return;

    log('$logLabel INFO ------------------------------------');
    log('🆔 ID: ${user.data['id'] ?? 'N/A'}');
    log('✉️ Email: ${user.data['email'] ?? 'N/A'}');
    log('👤 Name: ${user.data['name'] ?? 'N/A'}');
    log('✅ Verified: ${user.data['verified'] ?? 'N/A'}');
    log('🕒 Updated: ${user.data['updated'] ?? 'N/A'}');
    log('-----------------------------------------------');
  }
}
