import 'package:dox_sample/models/admin/admin.model.dart';

class AdminService {
  final Admin model;

  AdminService(this.model);

  Future<Admin> createAdmin(String email, String password) async {
    Admin admin = model.newQuery;
    admin.name = 'Dox';
    admin.email = email;
    admin.password = password;
    await admin.save();
    return admin;
  }
}
