import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/http/response_handler.dart';
import 'package:dox_sample/routes/api.dart';
import 'package:dox_sample/routes/web.dart';

class Config extends AppConfig {
  @override
  int get totalIsolate => 3;

  @override
  String get appKey => Env.get('APP_KEY');

  @override
  int get serverPort => int.parse(Env.get('APP_PORT', 3000));

  @override
  Map<Type, Function()> get formRequests => <Type, Function()>{};

  @override
  List<dynamic> get globalMiddleware => <dynamic>[];

  @override
  List<Router> get routers => <Router>[
        WebRouter(),
        ApiRouter(),
      ];

  @override
  CORSConfig get cors => CORSConfig();

  @override
  ResponseHandlerInterface get responseHandler => ResponseHandler();
}
