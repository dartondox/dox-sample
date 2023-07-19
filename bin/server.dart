import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';

void main() async {
  Config config = Config();

  Dox dox = Dox();

  /// Initialize Postgres connection
  Database().setup(config);

  /// run migration
  await Database().migrate();

  /// Initialize Dox server
  await dox.initialize(config);
}
