import 'package:dox_query_builder/dox_query_builder.dart';

part 'user.model.g.dart';

@DoxModel()
class User extends UserGenerator {
  @override
  List<String> get hidden => <String>[];
}
