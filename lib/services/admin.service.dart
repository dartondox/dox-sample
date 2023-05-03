import 'package:dox_sample/models/admin.model.dart';

class AdminService {
  final Admin model;

  AdminService(this.model);

  Future<Admin> createAdmin(String email) async {
    Admin admin = Admin();
    admin.name = 'AJ';
    admin.email = email;
    admin = await admin.save();
    return admin;
  }
}
