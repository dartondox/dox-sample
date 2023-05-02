import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/di.dart';

void main() async {
  /// Initialize Dox
  Dox.initialize(Config());

  /// register Ioc injector
  Ioc.register();
}
