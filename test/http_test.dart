import 'package:dox_core/testing.dart';
import 'package:dox_sample/config/app.dart';
import 'package:test/test.dart';

void main() {
  late DoxTestClient client;

  setUpAll(() async {
    client = await DoxTestClient.start(appConfig);
  });

  tearDownAll(() async {
    await client.close();
  });

  test('GET /api/ping', () async {
    TestResponse res = await client.get('/api/ping');
    res.expectStatus(200).expectBody('pong');
  });
}
