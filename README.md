# Dox Sample

## [Full documentation here](https://www.dartondox.dev/)

## Run project
- `cp .env.example .env`
- `dox serve`

## Build project
- `dox build`

## Create Model
- `dox create:model ModelName`
- `dox create:model ModelName -m ` // with migration

## Create Controller
- `dox create:controller ControllerName`
- `dox create:controller ControllerName -r ` // resource controller

## Create Middleware
- `dox create:controller MiddlewareName`

## Create Migration
- `dox create:migration create_admin_table`

## Run Migration
- `dox migrate`

## Rollback Migration
- `dox migrate:rollback`
