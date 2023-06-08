import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/http/controllers/api.controller.dart';

class ApiRouter extends Router {
  @override
  String get prefix => 'api';

  @override
  List<dynamic> get middleware => <dynamic>[];

  @override
  void register() {
    ApiController api = ApiController();

    Route.get('/ping', api.pong);
  }
}
