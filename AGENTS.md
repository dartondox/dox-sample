# AGENTS.md

Rules for AI coding tools that work on this project.
Read this file before you change any code.

## What this project is

This is a Dox app. Dox is a backend web framework for Dart.
The package name is `dox_sample`. Imports use `package:dox_sample/...`.

Full docs:

- https://dartondox.dev/llms-full.txt: all docs in one text file.
- https://dartondox.dev/llms.txt: the list of doc pages.

Read the docs before you guess an API. Do not invent class or method names.
Look at the code that is already in this project, and copy its style.

Step-by-step recipes (new endpoint, model, job, middleware, test) are in
`.agents/skills/dox/SKILL.md`. Open it as a normal file if your tool has no skill support.

## Folder layout

| Path | What goes there |
| --- | --- |
| `lib/app/http/controllers/` | Controllers. File: `<name>.controller.dart`, class `<Name>Controller`. |
| `lib/app/http/middleware/` | Middleware. File: `<name>.middleware.dart`. |
| `lib/app/serializers/` | Serializers (JSON shape of a response). File: `<name>.serializer.dart`. |
| `lib/app/dtos/<name>/` | DTOs (checked input). File: `<name>.dto.dart`. |
| `lib/app/models/<name>/` | ORM models. File: `<name>.model.dart`, plus the made `<name>.model.g.dart`. |
| `lib/app/jobs/` | Queue jobs. File: `<name>.job.dart`. |
| `lib/config/` | App config. `env.dart` is the typed env. `app.dart` is the main `AppConfig`. |
| `lib/routes/` | Routers. `api.dart` (prefix `api`) and `web.dart` (no prefix). |
| `lib/providers/` | Providers that start services (ORM, queue, storage, scheduler). |
| `lib/generated/` | Made by build_runner. Never edit. |
| `db/migration/` | Migrations. `migrations.dart` is the list. The CLI writes it. |
| `db/seeders/` | Seeders. `seeders.dart` is the list. The CLI writes it. |
| `db/factories/` | Model factories. File: `<name>.factory.dart`. |
| `bin/` | Entry points: `server.dart`, `migrate.dart`, `seed.dart`, `queue.dart`, `schedule.dart`. |
| `test/` | Tests. `http_test.dart` shows how to test routes. |

The docs also put services in `lib/app/services/` and repositories in `lib/app/repositories/`.
Use them when a controller gets long. Mark them with `@Inject()`.

## Make files with the CLI

Use the `dox` CLI to make new files. Do not write them by hand.
The CLI puts each file in the right folder, with the right name and base code.

| Command | Makes |
| --- | --- |
| `dox make:controller Post` | `lib/app/http/controllers/post.controller.dart` |
| `dox make:controller Post -r` | the same, with the resource methods (index, store, show, ...) |
| `dox make:model Post` | `lib/app/models/post/post.model.dart` |
| `dox make:model Post -m` | the model and a `create_posts_table` migration |
| `dox make:migration create_posts_table` | a Dart migration in `db/migration`, and updates `migrations.dart` |
| `dox make:dto SavePost` | `lib/app/dtos/save_post/save_post.dto.dart` |
| `dox make:serializer Post` | `lib/app/serializers/post.serializer.dart` |
| `dox make:middleware Auth` | `lib/app/http/middleware/auth.middleware.dart` |
| `dox make:job SendReport` | `lib/app/jobs/send_report.job.dart` |
| `dox make:factory Post` | `db/factories/post.factory.dart` |
| `dox make:seeder Post` | `db/seeders/post.seeder.dart`, and updates `seeders.dart` |

Other commands:

- `dox s`: dev server with hot reload. It also runs build_runner in watch mode.
- `dox build_runner:build`: run the code generator once.
- `dox migration:run`, `dox migration:rollback`, `dox migration:status`: run migrations.
- `dox db:seed`: run `DatabaseSeeder`. `dox db:seed --class=UserSeeder` runs one seeder.
- `dox queue:work`: run queued jobs.
- `dox schedule:list`, `dox schedule:work`: scheduled tasks of `lib/config/schedule.dart`.
- `dox key:generate`: write a new `APP_KEY` to `.env`.
- `dox env:check`: check `.env` against `lib/config/env.dart`.
- `dox build`: build the native binaries for production.
- `dox help`: list all commands.

## Code generation

Dox does not use reflection. A generator writes the wiring code.
Run it after you add or change any of these:

- a class with `@Inject()` (controllers, services)
- a `Router`, a `DoxProvider`
- a model (`@DoxModel`, `@Column`)
- a DTO (`@Dto`)
- a job (`@Job`)
- `lib/config/env.dart`

Run one of these:

```bash
dart run build_runner build
dox build_runner:build
```

`dox s` runs it for you while it is running.

Never edit generated files by hand:

- `*.g.dart` files
- everything in `lib/generated/`
- `db/migration/migrations.dart` and `db/seeders/seeders.dart` (the CLI writes them)

## Conventions

- **Container.** Put `@Inject()` above controllers and services. Dox makes them and fills their constructors.
  The generator adds them to `lib/generated/container.g.dart`. Do not register classes by hand.
- **Routes.** A router extends `Router` and adds routes in `register()`.
  Dox finds every `Router` class. Do not add routers to a list.
  A route points to a controller method: `Route.get('/ping', (ApiController c) => c.pong);`.
- **Input.** Check request input with a `@Dto` class. Ask for the DTO as a controller parameter.
  Bad input gets a `422` answer, and the controller does not run.
- **Models.** Every model sets `fillable`. Without it, `create(map)` and `update(map)` throw.
  Put secret columns (like `password`) in `hidden`.
- **Migrations.** Make them with `dox make:migration`. Each one has `up` and `down`.
  `bin/server.dart` runs new migrations when the server starts.
- **Jobs.** A job has `@Job()` and extends `DoxJob`. Save ids in a job, not whole objects.
  Jobs are listed in `lib/generated/jobs.g.dart`, made by the generator.
- **Config.** Read env values from the typed `env` of `lib/config/env.dart` (like `env.appPort`).
  To add a key: add a getter to `AppEnv`, add the key to `.env.example`, then run the generator.
- **Errors.** Throw `NotFoundHttpException()` and other HTTP exceptions. Dox turns them into answers.
- **Style.** The lints in `analysis_options.yaml` ask for types everywhere (`always_specify_types`).
  Write `List<String> names = <String>[];`, not `var names = [];`.

## Switch the database

The app uses SQLite by default. The build skips the Postgres and MySQL drivers.
This is set in the `hooks: user_defines:` block at the end of `pubspec.yaml`.

To use Postgres or MySQL:

1. Set `DB_CONNECTION=postgres` (or `mysql`) and the other `DB_*` keys in `.env`.
2. In `pubspec.yaml`, remove the `skip: true` line of that driver (`dox_postgres_native` or `dox_mysql_native`).
   Remove its name line too when nothing is left under it.
3. Run `dart pub get`, then start the app again.

Without step 2 the app stops with an error: the native library is not in the build.
After the switch, you may add `sqlite3: source: system` under `user_defines`.
The build then uses the SQLite library of the system and does not download one.
Only do this when the app never opens SQLite. A system without `libsqlite3` (like the Docker image) then fails at runtime.
`docker compose up` runs the app on Postgres, so it needs step 2 too.

## Check your work

Run these before you say a change is done:

```bash
dart format .
dart analyze
dart test
```

- `dart analyze` must show no issues.
- `dart test` needs a `.env` file with `APP_KEY` (32 characters). `dox create` makes it.
  Without it: `cp .env.example .env`, then `dox key:generate`.
- The tests use the database of `.env`. By default it is SQLite (`db/dox.sqlite`), so no setup is needed.
  A `.env.testing` file is read on top of `.env` during tests, for example with `DB_NAME=test.sqlite`.
- A test that uses the database must run the migrations first. See `test/db_test.dart`.

## Do not

- Do not edit generated files (`*.g.dart`, `lib/generated/`, `migrations.dart`, `seeders.dart`).
- Do not put secrets in code. Keys and passwords go in `.env`, read through `lib/config/env.dart`.
- Do not commit `.env`.
- Do not change a migration that already ran. Make a new migration instead.
- Do not use `dart:mirrors`. Dox builds to native code, which has no mirrors.
- Do not use `dart run` or `dox s` in production. Use `dox build`.
