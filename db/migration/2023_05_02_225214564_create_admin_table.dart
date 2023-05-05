import 'package:dox_core/dox_core.dart'; // ignore: file_names

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
