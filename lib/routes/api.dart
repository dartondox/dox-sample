import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/http/controllers/admin.controller.dart';
import 'package:dox_sample/http/controllers/api.controller.dart';

class ApiRouter extends Router {
  @override
  String get prefix => 'api';

  @override
  List get middleware => [];

  @override
  register() {
    var api = ApiController();

    Route.get('/ping', [api.pong]);

    Route.resource('admins', AdminController());
  }
}
