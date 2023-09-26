// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseModel _$ErrorResponseModelFromJson(Map<String, dynamic> json) =>
    ErrorResponseModel(
      timestamp: json['timestamp'] as String?,
      status: json['status'] as int?,
      path: json['path'] as String?,
      timeStamp: json['timeStamp'] as String?,
      message: json['message'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ErrorResponseModelToJson(ErrorResponseModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'status': instance.status,
      'error': instance.error,
      'path': instance.path,
      'timeStamp': instance.timeStamp,
      'message': instance.message,
    };
