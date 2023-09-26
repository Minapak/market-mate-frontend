// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_pagination_params_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicPaginationParams _$BasicPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    BasicPaginationParams(
      id: json['id'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$BasicPaginationParamsToJson(
        BasicPaginationParams instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page': instance.page,
      'limit': instance.limit,
    };
