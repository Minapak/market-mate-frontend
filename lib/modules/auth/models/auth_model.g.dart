// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      identyKey: json['identyKey'] as String?,
      userUUID: json['userUUID'] as String?,
      role: _$JsonConverterFromJson<String, UserRole>(
          json['role'], const UserRoleConverter().fromJson),
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'identyKey': instance.identyKey,
      'userUUID': instance.userUUID,
      'role': _$JsonConverterToJson<String, UserRole>(
          instance.role, const UserRoleConverter().toJson),
    };
///이 메서드는 JSON 데이터를 Json 형식의 값으로 역직렬화하는 역할
Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
/// 이 메서드는 Json 형식의 값을 JSON 데이터로 직렬화하는 역할
Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
