import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/cache.dart';
import 'package:dox_sample/config/cors.dart';
import 'package:dox_sample/config/logger.dart';
import 'package:dox_sample/config/env.dart';
import 'package:dox_sample/generated/container.g.dart';
import 'package:dox_sample/generated/dtos.g.dart';

/// HTTPS without a proxy, from `TLS_CERT` and `TLS_KEY`.
/// Null (plain HTTP) when one of them is not set.
TlsOptions? tlsOptions() {
  String? cert = env.tlsCert;
  String? key = env.tlsKey;
  if (cert == null || key == null) {
    return null;
  }
  return TlsOptions(certificatePath: cert, keyPath: key);
}

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
  /// Default is one per CPU the process may use.
  /// Set `APP_TOTAL_ISOLATE` to change it.
  totalIsolate: env.appTotalIsolate,

  /// HTTP/2
  /// -------------------------------
  /// HTTP/2 over plain TCP (h2c) on the same port as HTTP/1.1,
  /// eg. for gRPC. Off by default. Set `APP_HTTP2=true` to turn it on.
  http2: env.appHttp2 ?? false,

  /// HTTPS without a proxy
  /// -------------------------------
  /// Off by default. Set `TLS_CERT` and `TLS_KEY` to the certificate
  /// file and the key file (PEM). The port then accepts only HTTPS.
  tls: tlsOptions(),

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

  /// Strict mode
  /// -------------------------------
  /// Only in development. It warns in the log when a handler blocks the
  /// isolate, or when sync `Hash.make` / `Hash.verify` runs in the web server.
  /// Fix the warning. Do not turn strict mode off.
  strict: StrictConfig(enabled: Env.appEnv == 'development'),

  /// Cache stores (config/cache.dart)
  cache: cache,

  /// Cors configuration
  cors: cors,

  /// logger configuration
  logger: logger,
);
