import 'package:dox_core/dox_core.dart';

part 'admin.model.g.dart';

@IsModel()
class Admin extends Model with SoftDeletes {
  @override
  List<String> get hidden => ['password'];

  @JsonKey()
  int? id;

  @JsonKey()
  String? name;

  @JsonKey()
  String? status;

  @JsonKey()
  String? email;

  @JsonKey(fromJson: hashPassword)
  String? password;

  @JsonKey(name: 'deleted_at')
  DateTime? deletedAt;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  @override
  fromJson(Map<String, dynamic> json) => _$AdminFromJson(json);

  @override
  toMap() => _$AdminToJson(this);

  static hashPassword(data) {
    return Hash.make(data);
  }
}
