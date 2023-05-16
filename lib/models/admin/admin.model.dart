import 'package:dox_core/dox_core.dart';

part 'admin.model.g.dart';

@DoxModel()
class Admin extends AdminGenerator with SoftDeletes {
  @override
  List<String> get hidden => ['password'];

  @Column()
  String? name;

  @Column()
  String? status;

  @Column()
  String? email;

  @Column(beforeSave: hashPassword)
  String? password;

  @Column(name: 'deleted_at')
  DateTime? deletedAt;

  static hashPassword(Map<String, dynamic> data) {
    return Hash.make(data['password']);
  }
}
