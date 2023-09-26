// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      id: json['id'] as int,
      content: json['content'] as String,
      star: json['star'] as int,
      activate: json['activate'] as bool,
      user: MemberModel.fromJson(json['user'] as Map<String, dynamic>),
      createdDateTime: json['createdDateTime'] as String?,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'star': instance.star,
      'activate': instance.activate,
      'createdDateTime': instance.createdDateTime,
      'user': instance.user,
    };
