import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/exception/handler.dart';
import 'package:dox_sample/routes/api.dart';
import 'package:dox_sample/routes/web.dart';

class Config implements AppConfig {
  @override
  int get serverPort => int.parse(Env.get('APP_PORT', 3000));

  /// Database Driver
  @override
  String get dbDriver => Env.get('DB_DRIVER', DatabaseDriver.postgres);

  /// PostgresSQL credentials
  @override
  String get dbHost => Env.get('DB_HOST', 'localhost');
  @override
  int get dbPort => int.parse(Env.get('DB_PORT', '5432'));
  @override
  String get dbName => Env.get('DB_NAME', 'dox');
  @override
  String get dbUsername => Env.get('DB_USERNAME', 'postgres');
  @override
  String get dbPassword => Env.get('DB_PASSWORD', 'postgres');

  /// enable database query log in terminal
  @override
  bool get enableQueryLog => false;

  /// Exception Handler
  @override
  ExceptionHandler get exceptionHandler => ResponseExceptionHandler();

  @override
  List<Router> get routers => [
        WebRouter(),
        ApiRouter(),
      ];
}
