import 'package:dox_core/dox_core.dart';
import 'package:dox_migration/dox_migration.dart';
import 'package:dox_sample/config/app.dart';

void main() async {
  /// Initialize Dox
  Dox().initialize(appConfig);

  /// Run database migration before starting server.
  /// Since Migration need to process only once,
  /// it do not required to register in services.
  await Migration().migrate();

  /// Start dox http server
  await Dox().startServer();
}
