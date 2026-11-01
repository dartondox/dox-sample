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

  test('GET /ping (web routes have no prefix)', () async {
    TestResponse res = await client.get('/ping');
    res.expectStatus(200).expectBody('pong');
  });

  test('an unknown route gives 404', () async {
    TestResponse res = await client.get('/api/no-such-route');
    res.expectStatus(404);
  });

  test('a route answers only its own method', () async {
    TestResponse res = await client.post('/api/ping');
    expect(res.status, isNot(200));
  });
}
