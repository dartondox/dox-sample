import 'package:dox_core/dox_core.dart';
import 'package:dox_migration/dox_migration.dart';
import 'package:dox_sample/app/models/user/user.model.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';
import 'package:dox_sample/services/orm_service.dart';
import 'package:test/test.dart';

import '../db/migration/migrations.dart';

/// Uses the database of `.env` (SQLite by default, no setup needed).
void main() {
  setUpAll(() async {
    Dox().initialize(appConfig);
    await Migrator(
      migrations: migrations,
      config: databaseConfig.getConnectionConfig(),
    ).migrate();
    await ORMService().setup();
  });

  test('user model: save, find, soft delete', () async {
    String email = 'test-${DateTime.now().microsecondsSinceEpoch}@dox.dev';

    User user = User()
      ..name = 'Dox'
      ..email = email
      ..password = 'secret';
    await user.save();
    expect(user.id, isNotNull);

    User? found = await User().where('email', email).getFirst();
    expect(found?.name, 'Dox');
    expect(found?.toJson().containsKey('password'), isFalse);

    await found?.delete();
    expect(await User().where('email', email).getFirst(), isNull);
    expect(
      await User().withTrash().where('email', email).getFirst(),
      isNotNull,
    );

    User? trashed = await User().withTrash().where('email', email).getFirst();
    await trashed?.forceDelete();
    expect(await User().withTrash().where('email', email).getFirst(), isNull);
  });
}
