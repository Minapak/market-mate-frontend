// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqs_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqsPaginationParams _$FaqsPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    FaqsPaginationParams(
      page: json['page'] as int?,
      categoryId: json['categoryId'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$FaqsPaginationParamsToJson(
        FaqsPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'categoryId': instance.categoryId,
      'limit': instance.limit,
    };
