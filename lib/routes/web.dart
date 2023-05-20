import 'package:dox_core/dox_core.dart';
import 'package:dox_core/middleware/log_middleware.dart';
import 'package:dox_sample/http/controllers/web.controller.dart';

class WebRouter extends Router {
  @override
  List get middleware => [LogMiddleware()];

  @override
  register() {
    WebController web = WebController();

    Route.get('/ping', web.pong);
  }
}
