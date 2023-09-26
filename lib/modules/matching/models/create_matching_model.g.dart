// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_matching_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMatchingModel _$CreateMatchingModelFromJson(Map<String, dynamic> json) =>
    CreateMatchingModel(
      userUUID: json['userUUID'] as String,
      expertId: json['expertId'] as int,
      matchingStatus:
          $enumDecode(_$MatchingStatusEnumMap, json['matchingStatus']),
      activate: json['activate'] as bool,
    );

Map<String, dynamic> _$CreateMatchingModelToJson(
        CreateMatchingModel instance) =>
    <String, dynamic>{
      'userUUID': instance.userUUID,
      'expertId': instance.expertId,
      'matchingStatus': _$MatchingStatusEnumMap[instance.matchingStatus]!,
      'activate': instance.activate,
    };

const _$MatchingStatusEnumMap = {
  MatchingStatus.MATCHING_STANDBY: 'MATCHING_STANDBY',
  MatchingStatus.MATCHING_ACCEPT: 'MATCHING_ACCEPT',
  MatchingStatus.MANAGER_CONNECT: 'MANAGER_CONNECT',
  MatchingStatus.MATCHING_COMPLETE: 'MATCHING_COMPLETE',
  MatchingStatus.MATCHING_CANCEL: 'MATCHING_CANCEL',
};
