// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpertModel _$ExpertModelFromJson(Map<String, dynamic> json) => ExpertModel(
      id: json['id'] as int,
      name: json['name'] as String,
      content: json['content'] as String?,
      thumbnail: json['thumbnail'] as String?,
      marketName: json['marketName'] as String?,
      career: $enumDecodeNullable(_$ExpertCareerEnumMap, json['career']),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      mainCategories: (json['mainCategories'] as List<dynamic>?)
          ?.map((e) => MainCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      middleCategories: (json['middleCategories'] as List<dynamic>?)
          ?.map((e) => MiddleCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExpertModelToJson(ExpertModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'marketName': instance.marketName,
      'content': instance.content,
      'thumbnail': instance.thumbnail,
      'career': _$ExpertCareerEnumMap[instance.career],
      'images': instance.images,
      'mainCategories': instance.mainCategories,
      'middleCategories': instance.middleCategories,
    };

const _$ExpertCareerEnumMap = {
  ExpertCareer.UNTIL_FIVE_YEAR: 'UNTIL_FIVE_YEAR',
  ExpertCareer.UNTIL_TEN_YEAR: 'UNTIL_TEN_YEAR',
  ExpertCareer.UNTIL_TWENTY_YEAR: 'UNTIL_TWENTY_YEAR',
  ExpertCareer.UNTIL_THIRTY_YEAR: 'UNTIL_THIRTY_YEAR',
  ExpertCareer.OVER_THIRTY_YEAR: 'OVER_THIRTY_YEAR',
};
