// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_categories_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategoriesPaginationParams _$ServiceCategoriesPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    ServiceCategoriesPaginationParams(
      page: json['page'] as int?,
      serviceType: json['serviceType'] as String?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$ServiceCategoriesPaginationParamsToJson(
        ServiceCategoriesPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'serviceType': instance.serviceType,
      'limit': instance.limit,
    };
