import 'dart:io';

import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/cache.dart';
import 'package:dox_sample/config/cors.dart';
import 'package:dox_sample/config/logger.dart';
import 'package:dox_sample/config/env.dart';
import 'package:dox_sample/generated/container.g.dart';
import 'package:dox_sample/generated/dtos.g.dart';

AppConfig appConfig = AppConfig(
  /// Application secret key
  /// -------------------------------
  /// This key encrypts and checks cookies.
  /// It must be exactly 32 characters. Run `dox key:generate` to make one.
  /// Keep `APP_KEY` in an environment variable, never in the code.
  ///
  /// Note: if you change the key, all old cookies stop working,
  /// because they can not be decrypted any more.
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
  globalMiddleware: <dynamic>[
    /// one log line per request. off in production: the proxy logs there.
    LogMiddleware(enabled: env.appEnv != 'production'),
  ],

  /// Container
  /// -------------------------------
  /// Every @Inject class, router and provider of the app,
  /// from lib/generated/container.g.dart (made by build_runner).
  container: registerContainer,

  /// DTOs
  /// -------------------------------
  /// Every @Dto class of the app, from lib/generated/dtos.g.dart
  /// (made by build_runner). Add one with `dox make:dto`.
  dtos: dtos,

  /// Cache stores (config/cache.dart)
  cache: cache,

  /// Cors configuration
  cors: cors,

  /// logger configuration
  logger: logger,
);
