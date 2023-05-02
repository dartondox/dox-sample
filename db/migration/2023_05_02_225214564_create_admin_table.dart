import 'package:sql_query_builder/sql_query_builder.dart';

Future<void> up() async {
  await Schema.create('admin', (Table table) {
    table.id();
    table.string('name').nullable();
    table.string('email').unique();
    table.string('status').withDefault('active');
    table.softDeletes();
    table.timestamps();
  });
}

Future<void> down() async {
  await Schema.drop('admin');
}
