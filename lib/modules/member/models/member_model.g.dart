// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      uuid: json['uuid'] as String,
      identyKey: json['identyKey'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      phone: json['phone'] as String,
      thumbnail: json['thumbnail'] as String?,
      activate: json['activate'] as bool?,
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'identyKey': instance.identyKey,
      'name': instance.name,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'thumbnail': instance.thumbnail,
      'activate': instance.activate,
    };

UpdateMemberModel _$UpdateMemberModelFromJson(Map<String, dynamic> json) =>
    UpdateMemberModel(
      activate: json['activate'] as bool?,
      nickname: json['nickname'] as String?,
      password: json['password'] as String?,
      passwordVerify: json['passwordVerify'] as String?,
    );

Map<String, dynamic> _$UpdateMemberModelToJson(UpdateMemberModel instance) =>
    <String, dynamic>{
      'activate': instance.activate,
      'nickname': instance.nickname,
      'password': instance.password,
      'passwordVerify': instance.passwordVerify,
    };
