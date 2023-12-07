import 'package:dox_core/dox_core.dart';
import 'package:postgres_pool/postgres_pool.dart';

PgEndpoint postgresEndpoint = PgEndpoint(
  /// database host
  host: Env.get('DB_HOST', 'localhost'),

  /// database port
  port: Env.get<int>('DB_PORT', 5432),

  /// database name
  database: Env.get('DB_NAME', 'dox'),

  /// database username
  username: Env.get('DB_USERNAME', 'postgres'),

  /// database password
  password: Env.get('DB_PASSWORD', 'postgres'),
);
