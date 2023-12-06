import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/services/database.dart';

void main() async {
  /// Initialize Dox
  Dox().initialize(appConfig);

  /// Run database migration before starting server
  await Database().migrate();

  /// Start dox http server
  await Dox().startServer();
}
