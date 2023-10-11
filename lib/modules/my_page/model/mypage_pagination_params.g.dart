// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MypagePaginationParams _$MypagePaginationParamsFromJson(
        Map<String, dynamic> json) =>
    MypagePaginationParams(
      page: json['page'] as int?,
      mainCategoryId: json['mainCategoryId'] as int?,
      subCategoryId: json['subCategoryId'] as int?,
      limit: json['limit'] as int?,
    );

Map<String, dynamic> _$MypagePaginationParamsToJson(
        MypagePaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'mainCategoryId': instance.mainCategoryId,
      'subCategoryId': instance.subCategoryId,
      'limit': instance.limit,
    };
