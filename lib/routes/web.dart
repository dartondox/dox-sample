import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/app/http/controllers/web.controller.dart';

class WebRouter extends Router {
  @override
  List<dynamic> get middleware => <dynamic>[];

  @override
  void register() {
    Route.get('/ping', webController.pong);
  }
}
