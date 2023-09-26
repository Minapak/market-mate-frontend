// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
///JSON 속성 값을 추출하여 SigninModel 객체를 생성
SigninModel _$SigninModelFromJson(Map<String, dynamic> json) => SigninModel(
      identyKey: json['identyKey'] as String,
      password: json['password'] as String,
    );
///instance.identyKey 및 instance.password에서 SigninModel 객체의 속성 값을 가져와 JSON 맵으로 변환
Map<String, dynamic> _$SigninModelToJson(SigninModel instance) =>
    <String, dynamic>{
      'identyKey': instance.identyKey,
      'password': instance.password,
    };
