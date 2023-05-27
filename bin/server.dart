import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';

void main() async {
  Config config = Config();

  /// Initialize Dox
  Dox dox = Dox();
  dox.initialize(config);

  /// Initialize Postgres connection
  Database().setup(config);
}
