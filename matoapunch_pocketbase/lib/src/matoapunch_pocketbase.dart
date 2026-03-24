import 'package:matoapunch_pocketbase/matoapunch_pocketbase.dart';

export 'package:pocketbase/pocketbase.dart';

export 'entities/entities.dart';
export 'singletons/singletons.dart';

/// {@template matoapunch_pocketbase}
/// PocketBase wrapper entrypoint for MatoaPunch Studio projects.
/// {@endtemplate}
class MatoapunchPocketbase {
  /// Returns the shared package instance.
  factory MatoapunchPocketbase() => _instance;

  MatoapunchPocketbase._();

  static final MatoapunchPocketbase _instance = MatoapunchPocketbase._();

  /// Returns the user singleton.
  final PbSingleton user = PbSingleton();

  /// Returns the admin singleton.
  final PbAdminSingleton admin = PbAdminSingleton();

  /// Returns the user PocketBase client.
  PocketBase get userClient => user.pocketBase;

  /// Returns the admin PocketBase client.
  PocketBase get adminClient => admin.pocketBase;

  /// Initializes both user and admin PocketBase singletons.
  Future<void> init() async {
    await user.setup();
    await admin.setup();
  }

  /// Returns the admin PocketBase singleton.
  PbAdminSingleton get pbAdmin => admin;

  /// Returns the user PocketBase singleton.
  PbSingleton get pbUser => user;
}
