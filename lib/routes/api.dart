import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/http/controllers/api.controller.dart';

class ApiRouter extends Router {
  @override
  String get prefix => 'api';

  @override
  register() {
    var api = ApiController();

    Route.get('/', [api.pong]);
  }
}
