// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponseModel _$CategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesResponseModel(
      mainCategories: (json['mainCategories'] as List<dynamic>)
          .map((e) => MainCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      middleCategories: (json['middleCategories'] as List<dynamic>)
          .map((e) => MiddleCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesResponseModelToJson(
        CategoriesResponseModel instance) =>
    <String, dynamic>{
      'mainCategories': instance.mainCategories,
      'middleCategories': instance.middleCategories,
    };

MainCategoriesResponseModel _$MainCategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    MainCategoriesResponseModel(
      mainCategories: (json['mainCategories'] as List<dynamic>)
          .map((e) => MainCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MainCategoriesResponseModelToJson(
        MainCategoriesResponseModel instance) =>
    <String, dynamic>{
      'mainCategories': instance.mainCategories,
    };

MiddleCategoriesResponseModel _$MiddleCategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    MiddleCategoriesResponseModel(
      middleCategories: (json['middleCategories'] as List<dynamic>)
          .map((e) => MiddleCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MiddleCategoriesResponseModelToJson(
        MiddleCategoriesResponseModel instance) =>
    <String, dynamic>{
      'middleCategories': instance.middleCategories,
    };
