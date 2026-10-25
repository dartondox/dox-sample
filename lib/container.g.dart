// GENERATED CODE - DO NOT MODIFY BY HAND
// Made by dox_builder. Run `dart run build_runner build`.
// ignore_for_file: type=lint

import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/app/http/controllers/api.controller.dart' as i1;
import 'package:dox_sample/app/http/controllers/web.controller.dart' as i2;
import 'package:dox_sample/routes/api.dart' as i3;
import 'package:dox_sample/routes/web.dart' as i4;
import 'package:dox_sample/services/orm_service.dart' as i5;
import 'package:dox_sample/app/models/user/user.model.dart' as i6;

/// Puts every class of the app into the container: the
/// `@Inject()` classes, routers, services and model binders.
/// Use it in `AppConfig(container: registerContainer)`.
void registerContainer(IocContainer c) {
  c.singleton<i1.ApiController>((IocContainer c) => i1.ApiController());
  c.singleton<i2.WebController>((IocContainer c) => i2.WebController());
  c.router<i3.ApiRouter>((IocContainer c) => i3.ApiRouter());
  c.router<i4.WebRouter>((IocContainer c) => i4.WebRouter());
  c.service<i5.ORMService>((IocContainer c) => i5.ORMService());
  c.bindModel<i6.User>((String id) {
    int? key = int.tryParse(id);
    if (key == null) return null;
    return i6.User().find(key);
  });
}
