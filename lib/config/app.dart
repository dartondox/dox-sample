import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/app/http/response_handler.dart';
import 'package:dox_sample/config/cache.dart';
import 'package:dox_sample/config/cors.dart';
import 'package:dox_sample/config/logger.dart';
import 'package:dox_sample/config/services.dart';
import 'package:dox_sample/config/storage.dart';
import 'package:dox_sample/routes/api.dart';
import 'package:dox_sample/routes/web.dart';
import 'package:dox_sample/config/env.dart';

AppConfig appConfig = AppConfig(
  /// Application secret key
  /// -------------------------------
  /// This key is use to encrypt/decrypt the data such as cache and cookies.
  /// Make sure to keep the `APP_KEY` as an environment variable and secure.
  ///
  /// Note: Changing the application key for an existing app will make all
  /// the cookies and cache invalid and also the existing encrypted data
  /// will not be decrypted.
  appKey: env.appKey,

  /// Server port
  /// -------------------------------
  /// App will be running on this port.
  serverPort: env.appPort,

  /// Total isolate (multi thread)
  /// -------------------------------
  /// Isolates that serve http requests, all on the same port.
  /// Default is one per CPU core, so the app uses all cores.
  /// Set `APP_TOTAL_ISOLATE` to change it.
  totalIsolate: env.appTotalIsolate ?? Platform.numberOfProcessors,

  /// Global middleware
  /// -------------------------------
  /// By registering global middleware here,
  /// middleware will be applied to all the routes.
  globalMiddleware: <dynamic>[LogMiddleware(enabled: true)],

  /// Routers
  /// -------------------------------
  /// Register routers to create route to dox framework.
  routers: <Router>[WebRouter(), ApiRouter()],

  /// Response handler
  responseHandler: ResponseHandler(),

  /// Cache stores (config/cache.dart)
  cache: cache,

  /// Storage disks (config/storage.dart)
  storage: storage,

  /// Cors configuration
  cors: cors,

  /// Service to run on multithread server
  services: services,

  /// logger configuration
  logger: logger,
);
