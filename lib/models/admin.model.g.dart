// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Admin _$AdminFromJson(Map<String, dynamic> json) => Admin()
  ..id = json['id'] as int?
  ..name = json['name'] as String?
  ..status = json['status'] as String?
  ..email = json['email'] as String?
  ..deletedAt = json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String)
  ..createdAt = json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String)
  ..updatedAt = json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String);

Map<String, dynamic> _$AdminToJson(Admin instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'email': instance.email,
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
