import 'package:dox_core/dox_core.dart';
import 'package:dox_query_builder/dox_query_builder.dart';
import 'package:postgres_pool/postgres_pool.dart';

class Database {
  late PgPool pool;

  setup(AppConfig appConfig) {
    var config = appConfig.dbConfig;
    pool = PgPool(
      PgEndpoint(
        host: config.dbHost,
        port: config.dbPort,
        database: config.dbName,
        username: config.dbUsername,
        password: config.dbPassword,
      ),
      settings: PgPoolSettings()
        ..maxConnectionAge = Duration(hours: 1)
        ..concurrency = 4,
    );

    /// Initialize Sql QueryBuilder
    SqlQueryBuilder.initialize(
      database: pool,
      debug: config.enableQueryLog,
    );
  }

  /// Declare as Singleton
  static final Database _i = Database._internal();
  factory Database() => _i;
  Database._internal();
}
