import 'package:dox_core/dox_core.dart';

part 'admin.model.g.dart';

@IsModel()
class Admin extends Model with SoftDeletes {
  @Column()
  int? id;

  @Column()
  String? name;

  @Column()
  String? status;

  @Column()
  String? email;

  @Column(name: 'deleted_at')
  DateTime? deletedAt;

  @Column(name: 'created_at')
  DateTime? createdAt;

  @Column(name: 'updated_at')
  DateTime? updatedAt;

  @override
  fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  @override
  toMap() => _$AdminToJson(this);
}
