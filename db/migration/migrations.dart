// Made by `dox make:migration` and the `dox migration:*` commands.
// Do not edit, it is made again from the files in this folder.
import 'package:dox_migration/dox_migration.dart';

import '2023_07_16_131937700_create_users_table.dart' as m1;
import '2026_10_25_000000000_create_queue_tables.dart' as m2;

/// all Dart migrations of db/migration, sorted by name
final List<MigrationEntry> migrations = <MigrationEntry>[
  MigrationEntry(
    '2023_07_16_131937700_create_users_table',
    m1.CreateUsersTable(),
  ),
  MigrationEntry(
    '2026_10_25_000000000_create_queue_tables',
    m2.CreateQueueTables(),
  ),
];
