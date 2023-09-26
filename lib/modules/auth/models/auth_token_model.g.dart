// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
///JSON 속성 값을 추출하여 AuthTokenModel 객체를 생성
AuthTokenModel _$AuthTokenModelFromJson(Map<String, dynamic> json) =>
    AuthTokenModel(
      accessToken: json['accessToken'] as String,
      xerk: json['xerk'] as String,
    );
///instance.accessToken 및 instance.xerk에서
///AuthTokenModel 객체의 속성 값을 가져와 JSON 맵으로 변환
Map<String, dynamic> _$AuthTokenModelToJson(AuthTokenModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'xerk': instance.xerk,
    };
