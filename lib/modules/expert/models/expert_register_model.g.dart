// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expert_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpertRegisterModel _$ExpertRegisterModelFromJson(Map<String, dynamic> json) => ExpertRegisterModel(
  id: json['id'] as int,
  thumbnail: json['thumbnail'] as String?,
  introduceExpert: json['introduceExpert'] as String?,
  introduceContent: json['introduceContent'] as String?,
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

Map<String, dynamic> _$ExpertRegisterModelToJson(ExpertRegisterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbnail': instance.thumbnail,
      'introduceExpert': instance.introduceExpert,
      'introduceContent': instance.introduceContent,
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
