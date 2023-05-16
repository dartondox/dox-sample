import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';
import 'package:dox_sample/config/di.dart';

void main() async {
  Config config = Config();

  Dox dox = Dox();

  /// Initialize Dox
  dox.initialize(config);

  /// Initialize Postgres connection
  setupDatabaseConnection(config);

  /// register Ioc injector
  Ioc.register();
}
