import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';
import 'package:dox_sample/config/di.dart';

void main() async {
  Config config = Config();

  /// Initialize Postgres connection
  Database().setup(config);

  /// Initialize Dox
  Dox dox = Dox();
  dox.initialize(config);

  /// register Ioc injector
  Ioc.register();
}
