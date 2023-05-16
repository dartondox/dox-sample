import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/services/admin.service.dart';

IocContainer ioc = IocContainer();

class Ioc {
  static register() {
    ioc.register<AdminService>((ioc) => AdminService());
  }
}

T inject<T>() {
  return ioc.get<T>();
}
