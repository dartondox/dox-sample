<div align="center">
<img src="https://raw.githubusercontent.com/dartondox/assets/main/dox-logo.png" width="70" />
</br></br>
<div style="display:inline-block">
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" height="20"/> <img src="https://github.com/dartondox/dox/actions/workflows/test.yaml/badge.svg?branch=main" height="20"/> <img src="https://img.shields.io/github/stars/dartondox/dox.svg" height="20"/> <img src="https://img.shields.io/github/forks/dartondox/dox.svg" height="20"/> <img src="https://img.shields.io/github/license/dartondox/dox.svg" height="20"/>
</div>
</div>

## About

The starter project for Dox apps. `dox create` copies it.
Docs: https://dartondox.dev/latest/

You need **Dart 3.13** or newer.

AI coding tools get their rules from `AGENTS.md`. The Dox packages ship step-by-step skills for them. See [AI coding tools](#ai-coding-tools).

## Quick start

```bash
dart pub global activate dox
dox create my_app
cd my_app                       # dox create made .env with a new APP_KEY
dart pub get
dart run skills@ get            # install the skills of the Dox packages for your AI coding tool
dox s                           # dev server with hot reload, http://localhost:3000
```

The app uses SQLite (`db/dox.sqlite`), so it needs no database setup.
For Postgres, run `docker compose up -d postgres` and set `DB_CONNECTION=postgres` and `DB_NAME=dox` in `.env`. The other `DB_*` keys of `.env.example` already match it.
Also remove the `dox_postgres_native:` line and the `skip: true` line under it, at the end of `pubspec.yaml`. The build skips the drivers that the app does not use.

Test the server:

```bash
curl http://localhost:3000/api/ping   # pong
```

## AI coding tools

`AGENTS.md` has the rules of this project. `CLAUDE.md` points to it.

The Dox packages ship skills: recipes with the real API of each package.
Install them with the [skills](https://pub.dev/packages/skills) CLI:

```bash
dart run skills@ get
```

It works with Claude Code, Codex, Cursor, GitHub Copilot and others.
It asks which skills to install. `--all` installs all of them. `--agent claude` (or `codex`, `cursor`, `copilot`, `generic`) picks the tool.
Run it again after you add or update a package.

| Skill | Package |
| --- | --- |
| `dox-core-guide` | `dox_core` |
| `dox-orm-guide` | `dox_orm` |
| `dox-migration-guide` | `dox_migration` |
| `dox-queue-guide` | `dox_queue` |
| `dox-scheduler-guide` | `dox_scheduler` |
| `dox-storage-guide` | `dox_storage` |
| `dox-cache-guide` | `dox_cache` |
| `dox-validation-guide` | `dox_validation` |
| `dox-openapi-guide` | `dox_openapi` |

The skills CLI only reads the packages listed in your own `pubspec.yaml`, not the packages they pull in.
To get the skill of another package (like `dox_auth`, or `ioredis` if you use Redis directly), add it to `pubspec.yaml`, then run the command again.

## Migrations

Migrations are Dart files in `db/migration`. Make one with `dox make:migration <name>`.
The server runs new ones when it starts. You can also run them with the CLI:

```bash
dox migration:run
dox migration:rollback
dox migration:refresh
dox db:seed
```

## Queue and scheduler

```bash
dox make:job SendReport    # a job in lib/app/jobs
dox queue:work             # run the jobs
dox schedule:list          # the tasks of lib/config/schedule.dart
dox schedule:work          # run the tasks on time
```

## Tests

```bash
dart test
```

The tests use the database of `.env`. For another SQLite file: `DB_NAME=test.sqlite dart test`.

## Production

Never use `dart run` or `dox s` in production. They use the JIT, which needs much more memory.
Build a native (AOT) binary:

```bash
dox build
```

It makes `build/bundle` with three binaries: `bin/server`, `bin/queue` (the worker) and `bin/schedule` (the scheduler).
Run the worker and the scheduler as their own processes, next to the server.

Or use Docker. The image holds only the binary (about 12 MB), on `FROM scratch`.
It has no `.env` file. Config comes from env variables. A real env variable wins over `.env`.

`docker compose up` runs the app on Postgres. First remove the `dox_postgres_native:` line and the `skip: true` line under it, at the end of `pubspec.yaml`.

```bash
docker compose up -d --build                       # app + queue worker + postgres

docker build -t my-app .                           # or only the image
docker run -p 3000:3000 --env-file .env -e DB_HOST=my-db-host my-app
```

The app uses one isolate per CPU core. Set `APP_TOTAL_ISOLATE` to change it.

## Security Vulnerabilities

Dox take the security of our framework seriously. If you identify any security vulnerabilities in our application, please notify us immediately by sending an email to support@dartondox.dev. We appreciate your responsible disclosure and will respond promptly to address and resolve any identified security issues. Your cooperation helps us maintain the integrity and safety of our software for all users.

## Contributing

We welcome contributions from the community! If you'd like to contribute to the Dox framework, please fork the repo and PR to us.

## License

This project is licensed under the [MIT License](LICENSE).

## Community

