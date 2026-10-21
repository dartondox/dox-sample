// GENERATED CODE - DO NOT MODIFY BY HAND
// Made by dox_builder. Run `dart run build_runner build`.
// ignore_for_file: type=lint

import 'package:dox_core/dox_core.dart';

/// OpenAPI docs found in the code.
/// Use it in `OpenApiConfig(registry: openApiRegistry)`.
const OpenApiRegistry openApiRegistry = OpenApiRegistry(
  operations: <OpenApiOperation>[
    OpenApiOperation(
      controller: 'ApiController',
      method: 'pong',
      argumentTypes: <String>['DoxRequest'],
      tags: <String>['Api'],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{'type': 'string'},
        ),
      },
    ),
    OpenApiOperation(
      controller: 'WebController',
      method: 'pong',
      argumentTypes: <String>['DoxRequest'],
      tags: <String>['Web'],
      responses: <int, ResponseDoc>{
        200: ResponseDoc(
          description: 'Successful response',
          schema: <String, dynamic>{'type': 'string'},
        ),
      },
    ),
  ],
  routes: <OpenApiRouteBinding>[
    OpenApiRouteBinding('GET', 'api/ping', 'ApiController.pong'),
    OpenApiRouteBinding('GET', '/ping', 'WebController.pong'),
  ],
  schemas: <String, Map<String, dynamic>>{},
);
