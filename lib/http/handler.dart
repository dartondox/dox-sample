import 'package:dox_core/dox_core.dart';
import 'package:dox_query_builder/dox_query_builder.dart';

class ResponseHandler extends Handler {
  @override
  handle(DoxResponse res) {
    var data = res.content;

    // handle Model response
    if (data is Model) {
      return data.toMap(removeHiddenField: true);
    }

    // handle list response
    if (data is List) {
      return data
          .map((e) => e is Model ? e.toMap(removeHiddenField: true) : e)
          .toList();
    }
  }
}
