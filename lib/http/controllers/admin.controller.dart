import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/di.dart';
import 'package:dox_sample/models/admin.model.dart';
import 'package:dox_sample/services/admin.service.dart';

class AdminController {
  /// GET /admins
  index(DoxRequest req) async {
    return await Admin().all();
  }

  /// GET /admins/create
  create(DoxRequest req) {
    return 'admin create view';
  }

  /// POST /admins
  store(DoxRequest req) async {
    try {
      var service = inject<AdminService>();
      return await service.createAdmin(req.input('email'));
    } catch (error) {
      return InternalErrorException(message: error.toString());
    }
  }

  /// GET /admins/{id}
  show(DoxRequest req, String id) async {
    return await Admin().find(id);
  }

  /// GET /admins/{id}/edit
  edit(DoxRequest req, String id) async {
    await Admin().find(id);
    return 'show edit view';
  }

  /// PUT|PATCH /admins/{id}
  update(DoxRequest req, String id) async {
    await Admin().where('id', id).update({'name': req.body['name']});
    return await Admin().newQuery.find(id);
  }

  /// DELETE /admins/{id}
  destroy(DoxRequest req, String id) async {
    return await Admin().where('id', id).delete();
  }
}
