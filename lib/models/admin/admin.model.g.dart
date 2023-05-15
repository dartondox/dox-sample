// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.model.dart';

// **************************************************************************
// Generator: DoxModelBuilder
// **************************************************************************

class AdminGenerator extends Model<Admin> {
  @override
  String get primaryKey => 'id';

  @override
  Map<String, dynamic> get timestampsColumn => {
        'created_at': 'created_at',
        'updated_at': 'updated_at',
      };

  int? get id => tempIdValue;

  set id(val) => tempIdValue = val;

  Admin get newQuery => Admin();

  @override
  List get preloadList => [];

  @override
  Map<String, Function> get relationsResultMatcher => {};

  @override
  Map<String, Function> get relationsQueryMatcher => {};

  @override
  Admin fromMap(Map<String, dynamic> m) => Admin()
    ..id = m['id'] as int?
    ..name = m['name'] as String?
    ..status = m['status'] as String?
    ..email = m['email'] as String?
    ..password = m['password'] as String?
    ..deletedAt = m['deleted_at'] == null
        ? null
        : DateTime.parse(m['deleted_at'] as String)
    ..createdAt = m['created_at'] == null
        ? null
        : DateTime.parse(m['created_at'] as String)
    ..updatedAt = m['updated_at'] == null
        ? null
        : DateTime.parse(m['updated_at'] as String);

  @override
  Map<String, dynamic> convertToMap(i) {
    Admin instance = i as Admin;
    return {
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'email': instance.email,
      'password': Admin.hashPassword(instance.password),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
  }
}
