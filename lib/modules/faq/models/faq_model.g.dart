// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqModel _$FaqModelFromJson(Map<String, dynamic> json) => FaqModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      activate: json['activate'] as bool,
      createdDateTime: json['createdDateTime'] as String,
    );

Map<String, dynamic> _$FaqModelToJson(FaqModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'activate': instance.activate,
      'createdDateTime': instance.createdDateTime,
    };
