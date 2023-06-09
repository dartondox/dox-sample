import 'package:dox_core/dox_core.dart';
import 'package:dox_core/middleware/log_middleware.dart';
import 'package:dox_sample/http/handler.dart';
import 'package:dox_sample/routes/api.dart';
import 'package:dox_sample/routes/web.dart';

class Config extends AppConfig {
  @override
  String get appKey => Env.get('APP_KEY');

  @override
  int get serverPort => int.parse(Env.get('APP_PORT', 3000));

  @override
  Map<Type, Function()> get formRequests => <Type, Function()>{};

  @override
  List<dynamic> get globalMiddleware => <dynamic>[
        LogMiddleware(),
      ];

  @override
  List<Router> get routers => <Router>[
        WebRouter(),
        ApiRouter(),
      ];

  @override
  DBConfig get dbConfig => DBConfig(
        dbDriver: Env.get('DB_DRIVER', DatabaseDriver.postgres),
        dbHost: Env.get('DB_HOST', 'localhost'),
        dbPort: int.parse(Env.get('DB_PORT', '5432')),
        dbName: Env.get('DB_NAME', 'dox'),
        dbUsername: Env.get('DB_USERNAME', 'postgres'),
        dbPassword: Env.get('DB_PASSWORD', 'postgres'),
        enableQueryLog: false,
      );

  @override
  CORSConfig get cors => CORSConfig(
        allowOrigin: '*',
      );

  @override
  Handler get responseHandler => ResponseHandler();
}
