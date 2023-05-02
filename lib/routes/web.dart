import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/http/controllers/web.controller.dart';
import 'package:dox_sample/http/middleware/custom.middleware.dart';
import 'package:dox_sample/http/middleware/function.middleware.dart';

class WebRouter extends Router {
  @override
  register() {
    WebController web = WebController();

    Route.get('/ping', web.pong);
    Route.get('/error', web.throwError);
    Route.get('/json', web.json);
    Route.get('/middleware', [CustomMiddleware(), web.pong]);

    /// with middleware
    Route.get('/func/middleware', [functionMiddleware, web.pong]);
    Route.get('/middleware', [CustomMiddleware(), web.pong]);
    Route.get('/multi/middleware', [
      CustomMiddleware(),
      functionMiddleware,
      web.pong,
    ]);

    /// with params
    Route.get('/admin/{name}', web.withParam);

    Route.get('/dependency', web.dependencyInjection);
  }
}
