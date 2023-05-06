import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/di.dart';

void main() async {
  Dox dox = Dox();

  /// Initialize Dox
  dox.initialize(Config());

  /// register Ioc injector
  Ioc.register();
}
