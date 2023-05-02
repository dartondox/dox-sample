import 'dart:io';

import 'package:dox_core/dox_core.dart';

class ResponseExceptionHandler extends ExceptionHandler {
  @override
  handle(dynamic data, HttpResponse res) {
    if (data is BaseHttpException) {
      res.statusCode = data.code;
      return {
        "code": data.code,
        "error_code": data.errorCode,
        "message": data.message,
      };
    }
  }
}
