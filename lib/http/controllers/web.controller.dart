import 'package:dox_core/dox_core.dart';

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
}
