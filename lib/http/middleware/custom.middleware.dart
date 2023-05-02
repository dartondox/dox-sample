import 'package:dox_core/dox_core.dart';

class CustomMiddleware extends DoxMiddleware {
  @override
  handle(DoxRequest req) {
    print('customer middleware get called');
    return req;
  }
}
