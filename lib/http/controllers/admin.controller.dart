import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/di.dart';
import 'package:dox_sample/services/admin.service.dart';

class AdminController {
  /// GET /admins
  index(DoxRequest req) {
    return 'listing';
  }

  /// GET /admins/create
  create(DoxRequest req) {
    return 'create';
  }

  /// POST /admins
  store(DoxRequest req) async {
    try {
      var service = inject<AdminService>();
      return await service.createAdmin(req.body['email']);
    } catch (error) {
      return InternalErrorException(message: error.toString());
    }
  }

  /// GET /admins/{id}
  show(DoxRequest req, String id) {
    return id;
  }

  /// GET /admins/{id}/edit
  edit(DoxRequest req, String id) {
    return id;
  }

  /// PUT|PATCH /admins/{id}
  update(DoxRequest req, String id) {
    return id;
  }

  /// DELETE /admins/{id}
  destroy(DoxRequest req, String id) {
    return id;
  }
}
