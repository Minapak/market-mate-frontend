// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_matching_ws_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMatchingWSModel _$CreateMatchingWSModelFromJson(Map<String, dynamic> json) =>
    CreateMatchingWSModel(
      userUUID: json['userUUID'] as String,
      wholesalerId: json['wholesalerId'] as int,
      matchingWSStatus:
      $enumDecode(_$MatchingWSStatusEnumMap, json['matchingWsStatus']),
      activate: json['activate'] as bool,
    );

Map<String, dynamic> _$CreateMatchingWSModelToJson(
    CreateMatchingWSModel instance) =>
    <String, dynamic>{
      'userUUID': instance.userUUID,
      'wholesalerId': instance.wholesalerId,
      'matchingWSStatus': _$MatchingWSStatusEnumMap[instance.matchingWSStatus]!,
      'activate': instance.activate,
    };

const _$MatchingWSStatusEnumMap = {
  MatchingWSStatus.MATCHING_STANDBY: 'MATCHING_STANDBY',
  MatchingWSStatus.MATCHING_ACCEPT: 'MATCHING_ACCEPT',
  MatchingWSStatus.MANAGER_CONNECT: 'MANAGER_CONNECT',
  MatchingWSStatus.MATCHING_COMPLETE: 'MATCHING_COMPLETE',
  MatchingWSStatus.MATCHING_CANCEL: 'MATCHING_CANCEL',
};
