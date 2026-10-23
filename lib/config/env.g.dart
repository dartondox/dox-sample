// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// Generator: DoxEnvBuilder
// **************************************************************************

class _$AppEnv extends AppEnv {
  _$AppEnv._({
    required this.appName,
    required this.appEnv,
    required this.isDevelopment,
    required this.appPort,
    required this.appKey,
    required this.appTotalIsolate,
    required this.logLevel,
    required this.cacheStore,
    required this.storageDisk,
    required this.dbConnection,
    required this.dbName,
    required this.dbHost,
    required this.dbPort,
    required this.dbUsername,
    required this.dbPassword,
  });

  @override
  final String appName;
  @override
  final String appEnv;
  @override
  final bool isDevelopment;
  @override
  final int appPort;
  @override
  final String appKey;
  @override
  final int? appTotalIsolate;
  @override
  final String logLevel;
  @override
  final String cacheStore;
  @override
  final String storageDisk;
  @override
  final String dbConnection;
  @override
  final String dbName;
  @override
  final String dbHost;
  @override
  final int? dbPort;
  @override
  final String dbUsername;
  @override
  final String dbPassword;

  /// reads and checks every key once. Throws `EnvException` with all
  /// missing or bad keys.
  static AppEnv load([EnvReader? reader]) {
    EnvReader r = reader ?? EnvReader();
    _$AppEnvDefaults d = _$AppEnvDefaults();
    String appName = r.string('APP_NAME') ?? d.appName;
    String appEnv = r.string('APP_ENV') ?? d.appEnv;
    bool isDevelopment = r.boolean('IS_DEVELOPMENT') ?? d.isDevelopment;
    int appPort = r.integer('APP_PORT') ?? d.appPort;
    String? appKey = r.string('APP_KEY');
    r.need('APP_KEY');
    int? appTotalIsolate = r.integer('APP_TOTAL_ISOLATE');
    String logLevel = r.string('LOG_LEVEL') ?? d.logLevel;
    String cacheStore = r.string('CACHE_STORE') ?? d.cacheStore;
    String storageDisk = r.string('STORAGE_DISK') ?? d.storageDisk;
    String dbConnection = r.string('DB_CONNECTION') ?? d.dbConnection;
    String dbName = r.string('DB_NAME') ?? d.dbName;
    String dbHost = r.string('DB_HOST') ?? d.dbHost;
    int? dbPort = r.integer('DB_PORT');
    String dbUsername = r.string('DB_USERNAME') ?? d.dbUsername;
    String dbPassword = r.string('DB_PASSWORD') ?? d.dbPassword;

    r.check();
    return _$AppEnv._(
      appName: appName,
      appEnv: appEnv,
      isDevelopment: isDevelopment,
      appPort: appPort,
      appKey: appKey!,
      appTotalIsolate: appTotalIsolate,
      logLevel: logLevel,
      cacheStore: cacheStore,
      storageDisk: storageDisk,
      dbConnection: dbConnection,
      dbName: dbName,
      dbHost: dbHost,
      dbPort: dbPort,
      dbUsername: dbUsername,
      dbPassword: dbPassword,
    );
  }
}

/// gives the getter bodies of [AppEnv] (the defaults)
class _$AppEnvDefaults extends AppEnv {
  @override
  String get appKey => throw StateError('APP_KEY has no default');
  @override
  int? get appTotalIsolate =>
      throw StateError('APP_TOTAL_ISOLATE has no default');
  @override
  int? get dbPort => throw StateError('DB_PORT has no default');
}
