import 'package:dox_core/dox_core.dart';
import 'package:test/test.dart';

/// dox_core exports the dox_validation schemas (`v`).
/// The same schema works in a route with `req.validateSchema(schema)`.
void main() {
  test('validation: user input with a fluent schema', () {
    ObjectSchema schema = v.object(<String, Schema<Object?>>{
      'name': v.string().trim().min(3),
      'email': v.string().email(),
    });

    ParseResult<Map<String, dynamic>> ok = schema.safeParse(<String, dynamic>{
      'name': '  Dox  ',
      'email': 'dox@dox.dev',
    });
    expect(ok.success, isTrue);
    expect(ok.value?['name'], 'Dox');

    ParseResult<Map<String, dynamic>> bad = schema.safeParse(<String, dynamic>{
      'name': 'Do',
      'email': 'not-an-email',
    });
    expect(bad.success, isFalse);
    expect(bad.errors.keys, containsAll(<String>['name', 'email']));
  });
}
