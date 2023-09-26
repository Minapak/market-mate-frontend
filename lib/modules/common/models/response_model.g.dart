// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseModel<T>(
      id: json['id'] as String,
      dateTime: json['dateTime'] as String,
      success: json['success'] as bool,
      response: fromJsonT(json['response']),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'dateTime': instance.dateTime,
      'success': instance.success,
      'response': toJsonT(instance.response),
      'error': instance.error,
    };
