import 'package:dox_core/dox_core.dart';
import 'package:dox_query_builder/dox_query_builder.dart';
import 'package:postgres_pool/postgres_pool.dart';

class Database {
  late PgPool pool;
  late PgEndpoint endPoint;

  void setup(AppConfig appConfig) {
    DBConfig config = appConfig.dbConfig;

    endPoint = PgEndpoint(
      host: config.dbHost,
      port: config.dbPort,
      database: config.dbName,
      username: config.dbUsername,
      password: config.dbPassword,
    );

    pool = PgPool(
      endPoint,
      settings: PgPoolSettings()
        ..maxConnectionAge = Duration(hours: 1)
        ..concurrency = 4,
    );

    /// Initialize Sql QueryBuilder
    SqlQueryBuilder.initialize(
      database: pool,
      debug: config.enableQueryLog,
      printer: ConsoleQueryPrinter(),
    );
  }

  Future<void> migrate() async {
    // uncomment below line to run migration on application startup
    // await Migration().migrate();
  }

  /// Declare as Singleton
  static final Database _i = Database._internal();
  factory Database() => _i;
  Database._internal();
}
