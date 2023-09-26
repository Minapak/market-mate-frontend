// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experts_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpertsPaginationParams _$ExpertsPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    ExpertsPaginationParams(
      page: json['page'] as int?,
      mainCategoryId: json['mainCategoryId'] as int?,
      subCategoryId: json['subCategoryId'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$ExpertsPaginationParamsToJson(
        ExpertsPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'mainCategoryId': instance.mainCategoryId,
      'subCategoryId': instance.subCategoryId,
      'limit': instance.limit,
    };
