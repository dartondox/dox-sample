class IocContainer {
  Map<Type, dynamic> dependencies = {};
  Map<Type, dynamic> singletonDependencies = {};

  register<T>(Function(IocContainer) callback) {
    dependencies[T] = () => callback(this);
  }

  registerSingleton<T>(Function(IocContainer) callback) {
    singletonDependencies[T] = callback(this);
  }

  _haveInSingleton<T>() {
    return singletonDependencies[T] != null;
  }

  T get<T>() {
    if (_haveInSingleton<T>()) {
      return singletonDependencies[T];
    }
    return dependencies[T]();
  }
}

class UserModel {
  UserModel() {
    print('creating user model');
  }

  sayHello() {
    print('hello from model');
  }
}

class UserService {
  final UserModel model;
  const UserService(this.model);
}

void main(List<String> args) {
  // IocContainer ioc = IocContainer();
  // ioc.registerSingleton<UserModel>((ioc) => UserModel());
  // ioc.register<UserService>((ioc) => UserService(ioc.get<UserModel>()));

  // UserService service = ioc.get<UserService>();
  // service.model.sayHello();

  // UserService service2 = ioc.get<UserService>();
  // service2.model.sayHello();
  String originalString = 'This//is//a//sample//{abcd}//';
  String replacedString = originalString.replaceAll(RegExp(r'/+'), '/');
  print(replacedString); // This/is/a/sample/string
}
