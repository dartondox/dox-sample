import 'package:dox_core/dox_core.dart';

part 'env.g.dart';

/// The env of the app, typed. Made by `dox env:generate`.
/// -------------------------------
/// Each getter reads one key: `appName` reads `APP_NAME`.
/// A getter body is the default. A nullable getter is optional.
/// Other getters are required: the app stops at startup when one is missing.
/// Run `dart run build_runner build` after you change this class.
@DoxEnv()
abstract class AppEnv {
  /// reads and checks every key once
  static AppEnv load([EnvReader? reader]) {
    return _$AppEnv.load(reader);
  }

  String get appName => 'dox';

  /// development, staging or production. Not set: production.
  String get appEnv => 'production';

  int get appPort => 3000;

  /// required: used to sign tokens and encrypt cookies
  String get appKey;

  /// isolates (threads) of the HTTP server. Null: one per CPU the process may use.
  int? get appTotalIsolate;

  /// HTTP/2 (h2c) on the same port as HTTP/1.1. Null: off.
  bool? get appHttp2;

  /// HTTPS without a proxy: the certificate file (PEM). Null: plain HTTP.
  String? get tlsCert;

  /// the private key file (PEM) of the certificate
  String? get tlsKey;

  String get logLevel => 'info';

  /// memory, file or redis
  String get cacheStore => 'file';

  /// local, s3 or memory
  String get storageDisk => 'local';

  /// sqlite, postgres or mysql
  String get dbConnection => 'sqlite';

  /// the database name. For SQLite: the file path.
  String get dbName => 'db/dox.sqlite';

  /// a database url, eg. `postgres://user:pass@host:5432/db`.
  /// When set, it wins over the DB_* keys (see DatabaseConfig.url).
  String? get databaseUrl;

  String get dbHost => 'localhost';

  /// null: 5432 for Postgres, 3306 for MySQL
  int? get dbPort;

  String get dbUsername => 'postgres';

  String get dbPassword => '';
}

/// The env of the app. Read and checked once, on first use.
final AppEnv env = AppEnv.load();
