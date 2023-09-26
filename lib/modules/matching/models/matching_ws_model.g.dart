// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_ws_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchingWSModel _$MatchingWSModelFromJson(Map<String, dynamic> json) =>
    MatchingWSModel(
      id: json['id'] as int,
      userUUId: json['userUUId'] as String,
      wholesaler: wholesalerModel.fromJson(json['expert'] as Map<String, dynamic>),
      matchingWSStatus:
      $enumDecode(_$MatchingWSStatusEnumMap, json['matchingStatus']),
      activate: json['activate'] as bool,
      createdDateTime: json['createdDateTime'] as String,
    );

Map<String, dynamic> _$MatchingWSModelToJson(MatchingWSModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userUUId': instance.userUUId,
      'wholesaler': instance.wholesaler,
      'matchingWSStatus': _$MatchingWSStatusEnumMap[instance.matchingWSStatus]!,
      'activate': instance.activate,
      'createdDateTime': instance.createdDateTime,
    };

const _$MatchingWSStatusEnumMap = {
  MatchingWSStatus.MATCHING_STANDBY: 'MATCHING_STANDBY',
  MatchingWSStatus.MATCHING_ACCEPT: 'MATCHING_ACCEPT',
  MatchingWSStatus.MANAGER_CONNECT: 'MANAGER_CONNECT',
  MatchingWSStatus.MATCHING_COMPLETE: 'MATCHING_COMPLETE',
  MatchingWSStatus.MATCHING_CANCEL: 'MATCHING_CANCEL',
};
