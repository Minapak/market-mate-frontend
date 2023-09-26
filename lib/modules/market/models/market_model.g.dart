// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketModel _$MarketModelFromJson(Map<String, dynamic> json) => MarketModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String?,
      thumbnail: json['thumbnail'] as String?,
      content: json['content'] as String?,
      latitude: json['latitude'] as int?,
      longitude: json['longitude'] as int?,
      mainCategories: (json['mainCategories'] as List<dynamic>?)
          ?.map((e) => MainCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      middleCategories: (json['middleCategories'] as List<dynamic>?)
          ?.map((e) => MiddleCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarketModelToJson(MarketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'address': instance.address,
      'content': instance.content,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'mainCategories': instance.mainCategories,
      'middleCategories': instance.middleCategories,
      'images': instance.images,
    };
