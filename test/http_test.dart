import 'package:dox_core/dox_core.dart';
import 'package:dox_sample/config/app.dart';
import 'package:dox_sample/config/database.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

Config config = Config();
String baseUrl = 'http://localhost:${config.serverPort}';

void main() {
  setUpAll(() async {
    await Dox().initialize(config);
    Database().setup(config);
    await Future<dynamic>.delayed(Duration(milliseconds: 500));
  });

  tearDownAll(() {
    Dox().server.close();
  });

  test('ping route', () async {
    Uri url = Uri.parse('$baseUrl/ping');
    http.Response response = await http.get(url);
    expect(response.statusCode, 200);
    expect(response.body, 'pong');
  });
}
