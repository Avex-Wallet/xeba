import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'dropbox_clientId')
  static const String dropboxClientId = _Env.dropboxClientId;

  @EnviedField(varName: 'dropbox_key')
  static const String dropboxKey = _Env.dropboxKey;

  @EnviedField(varName: 'dropbox_secret')
  static const String dropboxSecret = _Env.dropboxSecret;

  @EnviedField(varName: 'production_mode', defaultValue: true)
  static const bool productionMode = _Env.productionMode;

  @EnviedField(varName: 'verify_token', defaultValue: true)
  static const bool verifyToken = _Env.verifyToken;

  @EnviedField(varName: 'db_inspector', defaultValue: false)
  static const bool dbInspector = _Env.dbInspector;
}
