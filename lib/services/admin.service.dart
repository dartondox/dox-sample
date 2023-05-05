import 'package:dox_sample/models/admin.model.dart';

class AdminService {
  final Admin model;

  AdminService(this.model);

  Future<Admin> createAdmin(String email, String password) async {
    Admin admin = Admin();
    admin.name = 'Dox';
    admin.email = email;
    admin.password = password;
    admin = await admin.save();
    return admin;
  }
}
