// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityModel _$CommunityModelFromJson(Map<String, dynamic> json) =>
    CommunityModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      activate: json['activate'] as bool,
      communityCategory: CommunityCategoryModel.fromJson(
          json['communityCategory'] as Map<String, dynamic>),
      goods: json['goods'] as int?,
      comments: json['comments'] as int?,
      commnets_count: json['commnets_count'] as int?,
    );

Map<String, dynamic> _$CommunityModelToJson(CommunityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'activate': instance.activate,
      'goods': instance.goods,
      'comments': instance.comments,
      'commnets_count': instance.commnets_count,
      'communityCategory': instance.communityCategory.toJson(),
    };
