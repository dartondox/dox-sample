import 'package:dox_orm/dox_orm.dart';

part 'user.model.g.dart';

@DoxModel(table: 'users', softDelete: true)
class User extends UserGenerator {
  /// Columns that `User().create(map)` and `update(map)` may set.
  /// dox_orm throws a MassAssignmentException for a model without it.
  @override
  List<String> get fillable => <String>['name', 'email', 'password'];

  @override
  List<String> get hidden => <String>['password'];

  @Column()
  String? name;

  @Column()
  String? email;

  @Column()
  String? password;
}
