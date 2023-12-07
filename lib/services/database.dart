import 'package:dox_core/dox_core.dart';
import 'package:dox_query_builder/dox_query_builder.dart';
import 'package:dox_sample/config/postgres.dart';
import 'package:postgres_pool/postgres_pool.dart';

class Database implements DoxService {
  /// Declare as Singleton to use connection pool
  static final Database _i = Database._internal();
  factory Database() => _i;
  Database._internal();

  late PgPool pool;

  bool debug = false;

  int concurrency = 10;

  @override
  Future<void> setup() async {
    Database().pool = PgPool(
      postgresEndpoint,
      settings: PgPoolSettings()
        ..maxConnectionAge = Duration(hours: 1)
        ..concurrency = concurrency,
    );

    /// this will create connection pool initially when server started
    /// so prevent connecting to connection pool when calling API for first time
    await Database().pool.query('SELECT 1');

    /// Initialize Sql QueryBuilder
    SqlQueryBuilder.initialize(
      database: Database().pool,
      debug: debug,
      printer: ConsoleQueryPrinter(),
    );
  }
}
