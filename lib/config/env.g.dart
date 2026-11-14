// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// Generator: DoxEnvBuilder
// **************************************************************************

class _$AppEnv extends AppEnv {
  _$AppEnv._({
    required String? appName,
    required String? appEnv,
    required int? appPort,
    required this.appKey,
    required this.appTotalIsolate,
    required String? logLevel,
    required String? cacheStore,
    required String? storageDisk,
    required String? dbConnection,
    required String? dbName,
    required this.databaseUrl,
    required String? dbHost,
    required this.dbPort,
    required String? dbUsername,
    required String? dbPassword,
  }) : _$appName = appName,
       _$appEnv = appEnv,
       _$appPort = appPort,
       _$logLevel = logLevel,
       _$cacheStore = cacheStore,
       _$storageDisk = storageDisk,
       _$dbConnection = dbConnection,
       _$dbName = dbName,
       _$dbHost = dbHost,
       _$dbUsername = dbUsername,
       _$dbPassword = dbPassword;

  final String? _$appName;
  @override
  late final String appName = _$appName ?? super.appName;
  final String? _$appEnv;
  @override
  late final String appEnv = _$appEnv ?? super.appEnv;
  final int? _$appPort;
  @override
  late final int appPort = _$appPort ?? super.appPort;
  @override
  final String appKey;
  @override
  final int? appTotalIsolate;
  final String? _$logLevel;
  @override
  late final String logLevel = _$logLevel ?? super.logLevel;
  final String? _$cacheStore;
  @override
  late final String cacheStore = _$cacheStore ?? super.cacheStore;
  final String? _$storageDisk;
  @override
  late final String storageDisk = _$storageDisk ?? super.storageDisk;
  final String? _$dbConnection;
  @override
  late final String dbConnection = _$dbConnection ?? super.dbConnection;
  final String? _$dbName;
  @override
  late final String dbName = _$dbName ?? super.dbName;
  @override
  final String? databaseUrl;
  final String? _$dbHost;
  @override
  late final String dbHost = _$dbHost ?? super.dbHost;
  @override
  final int? dbPort;
  final String? _$dbUsername;
  @override
  late final String dbUsername = _$dbUsername ?? super.dbUsername;
  final String? _$dbPassword;
  @override
  late final String dbPassword = _$dbPassword ?? super.dbPassword;

  /// true while [load] runs. A default that reads the global `env` calls
  /// [load] again, and would loop until the stack overflows.
  static bool _$$loading = false;

  /// reads and checks every key once. Throws `EnvException` with all
  /// missing or bad keys. Then works out every default once, so a default
  /// that throws stops the app here, at startup.
  static AppEnv load([EnvReader? $reader]) {
    if (_$$loading) {
      throw StateError(
        'A default of AppEnv reads the global `env`. Use the getter directly: write `appEnv`, not `env.appEnv`.',
      );
    }
    _$$loading = true;
    try {
      EnvReader $r = $reader ?? EnvReader();
      String? appName = $r.string('APP_NAME');
      String? appEnv = $r.string('APP_ENV');
      int? appPort = $r.integer('APP_PORT');
      String? appKey = $r.string('APP_KEY');
      $r.need('APP_KEY');
      int? appTotalIsolate = $r.integer('APP_TOTAL_ISOLATE');
      String? logLevel = $r.string('LOG_LEVEL');
      String? cacheStore = $r.string('CACHE_STORE');
      String? storageDisk = $r.string('STORAGE_DISK');
      String? dbConnection = $r.string('DB_CONNECTION');
      String? dbName = $r.string('DB_NAME');
      String? databaseUrl = $r.string('DATABASE_URL');
      String? dbHost = $r.string('DB_HOST');
      int? dbPort = $r.integer('DB_PORT');
      String? dbUsername = $r.string('DB_USERNAME');
      String? dbPassword = $r.string('DB_PASSWORD');

      $r.check();
      _$AppEnv $env = _$AppEnv._(
        appName: appName,
        appEnv: appEnv,
        appPort: appPort,
        appKey: appKey!,
        appTotalIsolate: appTotalIsolate,
        logLevel: logLevel,
        cacheStore: cacheStore,
        storageDisk: storageDisk,
        dbConnection: dbConnection,
        dbName: dbName,
        databaseUrl: databaseUrl,
        dbHost: dbHost,
        dbPort: dbPort,
        dbUsername: dbUsername,
        dbPassword: dbPassword,
      );
      $env.appName;
      $env.appEnv;
      $env.appPort;
      $env.logLevel;
      $env.cacheStore;
      $env.storageDisk;
      $env.dbConnection;
      $env.dbName;
      $env.dbHost;
      $env.dbUsername;
      $env.dbPassword;

      return $env;
    } finally {
      _$$loading = false;
    }
  }
}
