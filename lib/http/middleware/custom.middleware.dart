import 'package:dox_core/dox_core.dart';

class CustomMiddleware extends DoxMiddleware {
  @override
  handle(DoxRequest req) {
    /// write your logic here
    return req;
  }
}
