// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      id: json['id'] as int,
      communityId: json['communityId'] as int,
      authorUUID: json['authorUUID'] as String,
      activate: json['activate'] as bool,
      content: json['content'] as String,
      createdDateTime: json['createdDateTime'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'communityId': instance.communityId,
      'authorUUID': instance.authorUUID,
      'activate': instance.activate,
      'createdDateTime': instance.createdDateTime,
      'content': instance.content,
    };
