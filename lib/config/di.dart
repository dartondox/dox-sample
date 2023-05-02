import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/models/admin.model.dart';
import 'package:dox_sample/services/admin.service.dart';

IocContainer ioc = IocContainer();

class Ioc {
  static register() {
    ioc.register<Admin>((ioc) => Admin());
    ioc.register<AdminService>((ioc) => AdminService(Admin()));
  }
}

T inject<T>() {
  return ioc.get<T>();
}
