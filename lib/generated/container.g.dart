// GENERATED CODE - DO NOT MODIFY BY HAND
// Made by dox_builder. Run `dart run build_runner build`.
// ignore_for_file: type=lint

import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/app/http/controllers/api.controller.dart' as i1;
import 'package:dox_sample/app/http/controllers/web.controller.dart' as i2;
import 'package:dox_sample/providers/orm_provider.dart' as i3;
import 'package:dox_sample/providers/queue_provider.dart' as i4;
import 'package:dox_sample/providers/schedule_provider.dart' as i5;
import 'package:dox_sample/providers/storage_provider.dart' as i6;
import 'package:dox_sample/routes/api.dart' as i7;
import 'package:dox_sample/routes/web.dart' as i8;
import 'package:dox_sample/app/models/user/user.model.dart' as i9;

/// Puts every class of the app into the container: the
/// `@Inject()` classes, routers, providers and model binders.
/// Use it in `AppConfig(container: registerContainer)`.
void registerContainer(IocContainer c) {
  c.singleton<i1.ApiController>((IocContainer c) => i1.ApiController());
  c.singleton<i2.WebController>((IocContainer c) => i2.WebController());
  c.provider<i3.ORMProvider>((IocContainer c) => i3.ORMProvider());
  c.provider<i4.AppQueueProvider>((IocContainer c) => i4.AppQueueProvider());
  c.provider<i5.ScheduleProvider>((IocContainer c) => i5.ScheduleProvider());
  c.provider<i6.AppStorageProvider>(
    (IocContainer c) => i6.AppStorageProvider(),
  );
  c.router<i7.ApiRouter>((IocContainer c) => i7.ApiRouter());
  c.router<i8.WebRouter>((IocContainer c) => i8.WebRouter());
  c.bindModel<i9.User>((String id) {
    int? key = int.tryParse(id);
    if (key == null) return null;
    return i9.User().find(key);
  });
}
