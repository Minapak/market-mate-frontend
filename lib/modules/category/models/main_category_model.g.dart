// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainCategoryModel _$MainCategoryModelFromJson(Map<String, dynamic> json) =>
    MainCategoryModel(
      id: json['id'] as int,
      path: json['path'] as String?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MainCategoryModelToJson(MainCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'name': instance.name,
    };
