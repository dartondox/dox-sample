import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';

void main() async {
  /// Initialize Dox
  Dox().initialize(Config());

  /// Add database connection to isolate
  Dox().addService(Database());

  /// Run database migration before starting server
  /// There's no need to incorporate migration into the service
  /// because it's a one-time operation.
  await Database().migrate();

  /// Start dox http server
  await Dox().startServer();
}
