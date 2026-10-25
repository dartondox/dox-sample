<div align="center">
<img src="https://raw.githubusercontent.com/dartondox/assets/main/dox-logo.png" width="70" />
</br></br>
<div style="display:inline-block">
<img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" height="20"/> <img src="https://github.com/dartondox/dox/actions/workflows/test.yaml/badge.svg?branch=main" height="20"/> <img src="https://img.shields.io/github/stars/dartondox/dox.svg" height="20"/> <img src="https://img.shields.io/github/forks/dartondox/dox.svg" height="20"/> <img src="https://img.shields.io/github/license/dartondox/dox.svg" height="20"/>
</div>
</div>

## Dox 3.x (alpha)

This branch uses Dox `3.0.0-alpha.12`. It can still change before the stable release.
Docs: https://dartondox.dev/latest/

You need **Dart 3.13** or newer.

## Quick start

```bash
dart pub global activate dox ^3.0.0-alpha
dox create my_app
cd my_app                       # dox create made .env with a new APP_KEY
dart pub get
dox s                           # dev server with hot reload, http://localhost:3000
```

The app uses SQLite (`db/dox.sqlite`), so it needs no database setup.
For Postgres, run `docker compose up -d postgres` and set `DB_CONNECTION=postgres` and the `DB_*` keys in `.env`.

Test the server:

```bash
curl http://localhost:3000/api/ping   # pong
```

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

```bash
docker compose up -d --build                       # app + postgres

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

<a href="https://discord.gg/pBfWrsvBSV"><img src="https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white"></a>
