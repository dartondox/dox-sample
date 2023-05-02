import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/di.dart';
import 'package:dox_sample/services/admin.service.dart';

class WebController {
  pong(DoxRequest req) {
    return 'pong';
  }

  throwError(DoxRequest req) {
    return UnAuthorizedException();
  }

  json(DoxRequest req) {
    return {
      "name": "dox",
      "lang": "dart",
    };
  }

  withParam(DoxRequest req, name) {
    return {"message": "hello $name"};
  }

  dependencyInjection(DoxRequest req) {
    var service = inject<AdminService>();
    return service.sayHello('Dox');
  }
}
