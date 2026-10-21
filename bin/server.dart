import 'package:dox_core/dox_core.dart';
import 'package:dox_migration/dox_migration.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';

void main() async {
  /// Initialize Dox
  Dox().initialize(appConfig);

  /// Run database migrations once, before the server starts.
  /// We pass a connection from config/database.dart, so the
  /// migration also works with env variables and no `.env` file.
  await Migration().migrate(
    await databaseConfig.getConnectionConfig().getDatabaseConnection(),
  );

  /// Start dox http server
  await Dox().startServer();
}
