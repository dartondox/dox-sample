import 'package:dox_core/dox_core.dart';

CORSConfig cors = CORSConfig(
  /// Enabled
  /// -------------------------------
  /// Turn CORS on or off for all HTTP requests.
  enabled: false,

  /// Origin
  /// -------------------------------
  /// The origins that may call the app (`Access-Control-Allow-Origin`).
  /// A browser accepts only one origin in this header.
  /// So use a list: Dox sends back the request origin only when it is
  /// in the list. Do not put many origins in one comma separated string.
  /// It is sent as it is, and browsers reject it.
  /// `'*'` allows every origin, but then `credentials` must be false.
  origin: <String>['http://localhost:3000'],

  /// Methods
  /// -------------------------------
  /// The allowed request methods (`Access-Control-Allow-Methods`).
  /// With `credentials: true` browsers do not accept `'*'`, so list them.
  methods: <String>['GET', 'HEAD', 'POST', 'PUT', 'PATCH', 'DELETE'],

  /// Headers
  /// -------------------------------
  /// The allowed request headers (`Access-Control-Allow-Headers`).
  /// With `credentials: true` browsers do not accept `'*'`, so list them.
  headers: <String>[
    'accept',
    'authorization',
    'content-type',
    'x-csrf-token',
    'x-xsrf-token',
    'x-requested-with',
  ],

  /// Expose Headers
  /// -------------------------------
  /// The response headers that browser code may read
  /// (`Access-Control-Expose-Headers`).
  exposeHeaders: <String>[
    'cache-control',
    'content-language',
    'content-type',
    'expires',
    'last-modified',
    'pragma',
  ],

  /// Credentials
  /// -------------------------------
  /// Send `Access-Control-Allow-Credentials`, so the browser sends cookies.
  /// It only works with a list of origins, not with `'*'`.
  credentials: true,

  /// MaxAge
  /// -------------------------------
  /// How long a browser may cache the preflight answer, in seconds
  /// (`Access-Control-Max-Age`).
  maxAge: 90,
);
