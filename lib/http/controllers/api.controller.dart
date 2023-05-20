import 'package:dox_core/dox_core.dart';

class ApiController {
  pong(DoxRequest req) {
    throw ValidationException(message: {"name": 'required'});
  }
}
