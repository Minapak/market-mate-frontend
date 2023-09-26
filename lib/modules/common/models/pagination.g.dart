// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination<T> _$PaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    Pagination<T>(
      hasMore: json['hasMore'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      content: (json['content'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$PaginationToJson<T>(
  Pagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'hasMore': instance.hasMore,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'content': instance.content.map(toJsonT).toList(),
    };
