// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerStatusDataSuccess<T> _$ServerStatusDataSuccessFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ServerStatusDataSuccess<T>(
      data: fromJsonT(json['data']),
    );

Map<String, dynamic> _$ServerStatusDataSuccessToJson<T>(
  ServerStatusDataSuccess<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
    };
