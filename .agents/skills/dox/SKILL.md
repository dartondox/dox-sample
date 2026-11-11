---
name: dox
description: Step-by-step recipes for this Dox (Dart backend) app. Use it when you add or change routes, controllers, DTOs, serializers, models, migrations, factories, seeders, queue jobs, middleware or tests in this project, or switch the database to Postgres or MySQL.
---

# Dox recipes

Read `AGENTS.md` first. It has the folder layout and the rules.
Full docs: https://dartondox.dev/llms-full.txt

The examples use a `Post` model. Change the names for your case.
Imports use the package name of this app: `package:dox_sample/...`.

## 1. A new model and migration

Stop `dox s` first. It runs new migrations at start, before you add the columns.

```bash
dox make:model Post -m
```

This makes `lib/app/models/post/post.model.dart` and `db/migration/<date>_create_posts_table.dart`.
It also updates `db/migration/migrations.dart`. Do not edit that list.

Add the columns to the migration:

```dart
// db/migration/<date>_create_posts_table.dart
// ignore_for_file: file_names
import 'package:dox_migration/dox_migration.dart';

class CreatePostsTable extends Migration {
  @override
  Future<void> up(Schema schema) async {
    await schema.create('posts', (Table table) {
      table.id();
      table.string('title');
      table.text('body');
      table.timestamps();
    });
  }

  @override
  Future<void> down(Schema schema) async {
    await schema.dropIfExists('posts');
  }
}
```

Add the fields to the model. Every column field is nullable.
`id`, `createdAt` and `updatedAt` come from the generated base class.
List the columns that `create(map)` and `update(map)` may set in `fillable`.

```dart
// lib/app/models/post/post.model.dart
import 'package:dox_orm/dox_orm.dart';

part 'post.model.g.dart';

@DoxModel(table: 'posts')
class Post extends PostGenerator {
  @override
  List<String> get hidden => <String>[];

  @override
  List<String> get fillable => <String>['title', 'body'];

  @Column()
  String? title;

  @Column()
  String? body;
}
```

Run the generator, then the migration:

```bash
dart run build_runner build
dox migration:run
dox migration:status
```

A factory and a seeder make test data:

```bash
dox make:factory Post
dox make:seeder Post
```

```dart
// db/factories/post.factory.dart
import 'package:dox_orm/factory.dart';
import 'package:dox_sample/app/models/post/post.model.dart';

class PostFactory extends Factory<Post> {
  @override
  Post definition() {
    Post post = Post();
    post.title = 'Hello';
    post.body = 'My first post.';
    return post;
  }
}
```

```dart
// db/seeders/post.seeder.dart
import 'package:dox_migration/dox_migration.dart';

import '../factories/post.factory.dart';

class PostSeeder extends Seeder {
  @override
  Future<void> run() async {
    await PostFactory().count(10).create();
  }
}
```

Add `PostSeeder()` to the list in `db/seeders/database.seeder.dart`.
Import `post.seeder.dart` at the top of `database.seeder.dart`. Then run `dox db:seed`.

Docs:

- https://dartondox.dev/latest/database/migration/
- https://dartondox.dev/latest/database/model/
- https://dartondox.dev/latest/database/factories/
- https://dartondox.dev/latest/database/seeders/

## 2. A new API endpoint

Goal: `POST /api/posts` checks the input, saves a post and answers with JSON.
It uses the `Post` model of recipe 1. Do recipe 1 first.

Make the files:

```bash
dox make:controller Post
dox make:dto SavePost
dox make:serializer Post
```

The DTO checks the input. A field that is not nullable is required.

```dart
// lib/app/dtos/save_post/save_post.dto.dart
import 'package:dox_core/dox_core.dart';

part 'save_post.dto.g.dart';

@Dto()
class SavePost {
  @Trim()
  @Length(min: 3, max: 100)
  final String title;

  @Trim()
  @MinLength(10)
  final String body;

  const SavePost({required this.title, required this.body});

  static const DtoSchema<SavePost> schema = $SavePostDto;
}
```

The serializer sets the JSON shape:

```dart
// lib/app/serializers/post.serializer.dart
import 'package:dox_core/dox_core.dart';

import 'package:dox_sample/app/models/post/post.model.dart';

class PostSerializer extends Serializer<Post> {
  PostSerializer(super.data);

  @override
  Map<String, dynamic> convert(Post m) {
    return <String, dynamic>{'id': m.id, 'title': m.title, 'body': m.body};
  }
}
```

The controller asks for the DTO as a parameter. Bad input gets `422`, and the method does not run.
A route param like `{id}` comes in as `int id`.

```dart
// lib/app/http/controllers/post.controller.dart
import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/app/dtos/save_post/save_post.dto.dart';
import 'package:dox_sample/app/models/post/post.model.dart';
import 'package:dox_sample/app/serializers/post.serializer.dart';

@Inject()
class PostController {
  Future<PostSerializer> index(DoxRequest req) async {
    return PostSerializer(await Post().all());
  }

  Future<DoxResponse> store(SavePost input) async {
    Post post = Post()
      ..title = input.title
      ..body = input.body;
    await post.save();
    return response(PostSerializer(post)).statusCode(201);
  }

  Future<PostSerializer> show(int id) async {
    Post? post = await Post().find(id);
    if (post == null) throw NotFoundHttpException();
    return PostSerializer(post);
  }
}
```

Add the routes in `lib/routes/api.dart`, inside `register()`. The router adds the `api` prefix.
Import `post.controller.dart` at the top of `api.dart`.

```dart
Route.get('/posts', (PostController c) => c.index);
Route.post('/posts', (PostController c) => c.store);
Route.get('/posts/{id}', (PostController c) => c.show);
```

Then run the generator. It adds the controller to the container and makes the DTO code.

```bash
dart run build_runner build
```

Docs:

- https://dartondox.dev/latest/the-basic/routing/
- https://dartondox.dev/latest/the-basic/controller/
- https://dartondox.dev/latest/the-basic/validation/
- https://dartondox.dev/latest/the-basic/serializer/

## 3. A queued job

```bash
dox make:job SendReport
```

The constructor params are saved with the job. Save ids and simple values, not whole objects.

```dart
// lib/app/jobs/send_report.job.dart
import 'package:dox_core/utils/logger.dart';
import 'package:dox_queue/dox_queue.dart';

@Job()
class SendReport extends DoxJob {
  SendReport({required this.userId});

  final int userId;

  @override
  int get tries => 3;

  @override
  Future<void> handle() async {
    Logger.info('Send the report of user $userId');
  }
}
```

Run the generator. It adds the job to `lib/generated/jobs.g.dart`.

```bash
dart run build_runner build
```

Dispatch it from a controller or a service:

Import `send_report.job.dart` at the top of that file.

```dart
await SendReport(userId: 1).dispatch();
await SendReport(userId: 1).dispatch(delay: Duration(minutes: 10));
```

Run the worker next to the server:

```bash
dox queue:work
```

Docs: https://dartondox.dev/latest/digging-deeper/queue/

## 4. Middleware on a group of routes

```bash
dox make:middleware ApiKey
```

Return `req` to go on to the controller. Return a response to stop the request.
Read the key from the typed env, not from the code. Add `String? get apiKey;` to `AppEnv` in `lib/config/env.dart`, add `API_KEY=` to `.env.example`, and run the generator.

```dart
// lib/app/http/middleware/api_key.middleware.dart
import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/env.dart';

class ApiKeyMiddleware implements IDoxMiddleware {
  @override
  dynamic handle(IDoxRequest req) {
    String key = env.apiKey ?? '';
    String given = req.header('X-Api-Key') ?? '';
    if (key.isEmpty || !Hash.equals(given, key)) {
      return response(<String, String>{'message': 'Unauthorized'})
          .statusCode(401);
    }
    return req;
  }
}
```

Put it on a group in `lib/routes/api.dart`, inside `register()`.
Recipe 2 already added the `/posts` routes there. Move the routes you want to guard into the group.
Delete their old lines. Do not add the same route twice.
Here, `GET /posts/{id}` stays outside the group, so it stays open.
Import `api_key.middleware.dart` at the top of `api.dart`.

```dart
Route.middleware(<dynamic>[ApiKeyMiddleware()], () {
  Route.get('/posts', (PostController c) => c.index);
  Route.post('/posts', (PostController c) => c.store);
});
```

For all routes of a router, return it from the `middleware` getter of the router.
For all routes of the app, add it to `globalMiddleware` in `lib/config/app.dart`.

Docs: https://dartondox.dev/latest/the-basic/middleware/

## 5. A test for an endpoint

Follow `test/http_test.dart`. `DoxTestClient.start` runs the app inside the test, on a free port.
Run the migrations first when the route uses the database.
A `Map` body is sent as JSON.
If recipe 4 put `POST /api/posts` behind `ApiKeyMiddleware`, set `API_KEY` in `.env`.
Then send the `X-Api-Key` header in every request to `POST /api/posts`, also in the 422 test: `client.post('/api/posts', body: ..., headers: <String, String>{'X-Api-Key': env.apiKey!})`.
`env` comes from `package:dox_sample/config/env.dart`.

```dart
// test/post_test.dart
import 'package:dox_core/testing.dart';
import 'package:dox_migration/dox_migration.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';
import 'package:test/test.dart';

import '../db/migration/migrations.dart';

void main() {
  late DoxTestClient client;

  setUpAll(() async {
    await Migrator(
      migrations: migrations,
      config: databaseConfig.getConnectionConfig(),
    ).migrate();
    client = await DoxTestClient.start(appConfig);
  });

  tearDownAll(() async {
    await client.close();
  });

  test('POST /api/posts saves a post', () async {
    TestResponse res = await client.post(
      '/api/posts',
      body: <String, dynamic>{'title': 'Hello', 'body': 'My first post.'},
    );
    res.expectStatus(201).expectJson(containsPair('title', 'Hello'));
  });

  test('POST /api/posts with bad input gives 422', () async {
    TestResponse res = await client.post(
      '/api/posts',
      body: <String, dynamic>{'title': 'Hi'},
    );
    res.expectStatus(422);
  });
}
```

```bash
dart test test/post_test.dart
```

Docs:

- https://dartondox.dev/latest/digging-deeper/testing/
- https://dartondox.dev/latest/guides/testing-with-database/

## 6. Switch to Postgres or MySQL

The app uses SQLite. The end of `pubspec.yaml` turns off the two other drivers:

```yaml
hooks:
  user_defines:
    dox_postgres_native:
      skip: true
    dox_mysql_native:
      skip: true
```

For Postgres, remove both `dox_postgres_native` lines (the name line and `skip: true`). Keep the MySQL skip.
You may also add `sqlite3: source: system`, so the build does not download SQLite:

```yaml
hooks:
  user_defines:
    dox_mysql_native:
      skip: true
    sqlite3:
      source: system
```

For MySQL, do the same with `dox_mysql_native`.
Only add `sqlite3: source: system` when the app never opens SQLite.
Then set `DB_CONNECTION` and the other `DB_*` keys in `.env`, and run `dart pub get`.

A driver that is still skipped stops the app with an error: the native library is not in the build.
The fix is to remove both lines of that driver (the name line and `skip: true`).

Docs: https://dartondox.dev/latest/database/#skip-unused-drivers

## Before you finish

```bash
dart format .
dart analyze
dart test
```
