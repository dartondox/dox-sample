import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/http/controllers/web.controller.dart';

class WebRouter extends Router {
  @override
  List<dynamic> get middleware => <dynamic>[];

  @override
  void register() {
    WebController web = WebController();

    Route.get('/ping', web.pong);
  }
}
