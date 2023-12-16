import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/app/http/response_handler.dart';
import 'package:dox_sample/config/cache.dart';
import 'package:dox_sample/config/cors.dart';
import 'package:dox_sample/config/logger.dart';
import 'package:dox_sample/config/services.dart';
import 'package:dox_sample/config/storage.dart';
import 'package:dox_sample/routes/api.dart';
import 'package:dox_sample/routes/web.dart';

AppConfig appConfig = AppConfig(
  /// Application secret key
  /// -------------------------------
  /// This key is use to encrypt/decrypt the data such as cache and cookies.
  /// Make sure to keep the `APP_KEY` as an environment variable and secure.
  ///
  /// Note: Changing the application key for an existing app will make all
  /// the cookies and cache invalid and also the existing encrypted data
  /// will not be decrypted.
  appKey: Env.get<String>('APP_KEY'),

  /// Server port
  /// -------------------------------
  /// App will be running on this port.
  serverPort: Env.get<int>('APP_PORT', 3000),

  /// Total isolate (multi thread)
  /// -------------------------------
  /// Total isolate to run the application.
  /// Depending on your machine CPU and RAM, you can adjust the the number
  /// of isolates. The more isolate application have, the more it can handle
  /// concurrency requests.
  totalIsolate: Env.get<int>('APP_TOTAL_ISOLATE', 3),

  /// Form requests
  /// -------------------------------
  /// Register form request to dox in order to inject into the controller.
  /// Example,
  /// {
  ///   BlogRequest : () => BlogRequest(),
  ///   UserRequest : () => UserRequest(),
  /// }
  formRequests: <Type, FormRequest Function()>{},

  /// Global middleware
  /// -------------------------------
  /// By registering global middleware here,
  /// middleware will be applied to all the routes.
  globalMiddleware: <dynamic>[
    LogMiddleware(enabled: true),
  ],

  /// Routers
  /// -------------------------------
  /// Register routers to create route to dox framework.
  routers: <Router>[
    WebRouter(),
    ApiRouter(),
  ],

  /// Response handler
  responseHandler: ResponseHandler(),

  /// Cache driver configuration
  cache: cache,

  /// File storage driver configuration
  fileStorage: storage,

  /// Cors configuration
  cors: cors,

  /// Service to run on multithread server
  services: services,

  /// logger configuration
  logger: logger,
);
