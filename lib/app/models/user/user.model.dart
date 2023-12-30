import 'package:dox_query_builder/dox_query_builder.dart';

part 'user.model.g.dart';

@DoxModel(softDelete: true)
class User extends UserGenerator {
  @override
  List<String> get hidden => <String>[];

  @Column()
  String? name;

  @Column()
  String? email;

  @Column()
  String? password;

  @Column()
  String? deletedAt;
}
