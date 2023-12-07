import 'package:dox_core/dox_core.dart';
import 'package:dox_migration/dox_migration.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/postgres.dart';

void main() async {
  /// Initialize Dox
  Dox().initialize(appConfig);

  /// Run database migration before starting server
  await Migration().migrate(postgresEndpoint);

  /// Start dox http server
  await Dox().startServer();
}
