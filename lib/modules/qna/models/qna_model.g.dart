// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qna_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QnaModel _$QnaModelFromJson(Map<String, dynamic> json) => QnaModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      activate: json['activate'] as bool,
      createdDateTime: json['createdDateTime'] as String,
    );

Map<String, dynamic> _$QnaModelToJson(QnaModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'activate': instance.activate,
      'createdDateTime': instance.createdDateTime,
    };
