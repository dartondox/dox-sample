import 'package:dox_core/dox_core.dart';
import 'package:dox_query_builder/dox_query_builder.dart';
import 'package:postgres_pool/postgres_pool.dart';

Future<dynamic> setupDatabaseConnection(AppConfig appConfig) async {
  var config = appConfig.dbConfig;
  PgPool db = PgPool(
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
  SqlQueryBuilder.initialize(database: db, debug: config.enableQueryLog);
}
