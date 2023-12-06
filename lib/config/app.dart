import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/cache.dart';
import 'package:dox_sample/config/cors.dart';
import 'package:dox_sample/config/services.dart';
import 'package:dox_sample/config/storage.dart';
import 'package:dox_sample/http/response_handler.dart';
import 'package:dox_sample/routes/api.dart';
import 'package:dox_sample/routes/web.dart';

AppConfig appConfig = AppConfig(
  /// application key,
  /// this key is use to encrypt/decrypt cache data and cookies.
  appKey: Env.get<String>('APP_KEY'),

  /// application server port
  serverPort: Env.get<int>('APP_PORT', 3000),

  /// total multi-thread isolate to run
  totalIsolate: Env.get<int>('APP_TOTAL_ISOLATE', 1),

  /// form requests
  formRequests: <Type, FormRequest Function()>{},

  /// global middleware
  globalMiddleware: <dynamic>[],

  /// routers
  routers: <Router>[
    WebRouter(),
    ApiRouter(),
  ],

  /// response handler
  responseHandler: ResponseHandler(),

  /// cache driver configuration
  cache: cache,

  /// file storage driver configuration
  fileStorage: storage,

  /// cors configuration
  cors: cors,

  /// service to run on multithread server
  services: services,
);
