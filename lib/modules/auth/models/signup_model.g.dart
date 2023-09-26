// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupModel _$SignupModelFromJson(Map<String, dynamic> json) => SignupModel(
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      identyKey: json['identyKey'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      activate: json['activate'] as bool,
    );

Map<String, dynamic> _$SignupModelToJson(SignupModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'nickname': instance.nickname,
      'identyKey': instance.identyKey,
      'password': instance.password,
      'phone': instance.phone,
      'activate': instance.activate,
    };
