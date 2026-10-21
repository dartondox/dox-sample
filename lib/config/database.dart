import 'package:dox_core/dox_core.dart';
import 'package:dox_orm/dox_orm.dart';

/// Print every SQL query only in development.
/// Printing each query costs time, so it is off in production.
bool _debug = Env.get('APP_ENV') == 'development';

DatabaseConfig databaseConfig = DatabaseConfig(
  /// Connection
  /// -------------------------------
  /// The connection to use. It is one key of `connections` below.
  connection: Env.get('DB_CONNECTION', 'postgres'),

  connections: <String, ConnectionConfig>{
    /// Postgres
    'postgres': ConnectionConfig(
      driver: Driver.postgres,
      host: Env.get('DB_HOST', 'localhost'),
      port: Env.get<int>('DB_PORT', 5432),
      user: Env.get('DB_USERNAME', 'postgres'),
      password: Env.get('DB_PASSWORD', 'postgres'),
      database: Env.get('DB_NAME', 'dox'),
      extra: <String, dynamic>{
        /// Each isolate has its own pool.
        'maxConnectionCount': 10,
        'maxConnectionAge': Duration(hours: 1),
      },
      debug: _debug,
      printer: PrettyQueryPrinter(),
    ),

    /// MySQL and MariaDB
    'mysql': ConnectionConfig(
      driver: Driver.mysql,
      host: Env.get('DB_HOST', 'localhost'),
      port: Env.get<int>('DB_PORT', 3306),
      user: Env.get('DB_USERNAME', 'root'),
      password: Env.get('DB_PASSWORD', 'password'),
      database: Env.get('DB_NAME', 'dox'),
      extra: <String, dynamic>{'collation': 'utf8mb4_general_ci'},
      debug: _debug,
      printer: PrettyQueryPrinter(),
    ),

    /// SQLite. `DB_NAME` is a file path, or `:memory:`.
    'sqlite': ConnectionConfig(
      driver: Driver.sqlite,
      database: Env.get('DB_NAME', 'dox.sqlite'),
      debug: _debug,
      printer: PrettyQueryPrinter(),
    ),
  },
);
