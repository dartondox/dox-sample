import 'package:dox_sample/models/admin.model.dart';

class AdminService {
  final Admin model;

  AdminService(this.model);

  sayHello(name) {
    return {"message": "hello $name"};
  }
}
