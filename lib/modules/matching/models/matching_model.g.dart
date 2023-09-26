// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matching_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchingModel _$MatchingModelFromJson(Map<String, dynamic> json) =>
    MatchingModel(
      id: json['id'] as int,
      userUUId: json['userUUId'] as String,
      expert: ExpertModel.fromJson(json['expert'] as Map<String, dynamic>),
      matchingStatus:
          $enumDecode(_$MatchingStatusEnumMap, json['matchingStatus']),
      activate: json['activate'] as bool,
      createdDateTime: json['createdDateTime'] as String,
    );

Map<String, dynamic> _$MatchingModelToJson(MatchingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userUUId': instance.userUUId,
      'expert': instance.expert,
      'matchingStatus': _$MatchingStatusEnumMap[instance.matchingStatus]!,
      'activate': instance.activate,
      'createdDateTime': instance.createdDateTime,
    };

const _$MatchingStatusEnumMap = {
  MatchingStatus.MATCHING_STANDBY: 'MATCHING_STANDBY',
  MatchingStatus.MATCHING_ACCEPT: 'MATCHING_ACCEPT',
  MatchingStatus.MANAGER_CONNECT: 'MANAGER_CONNECT',
  MatchingStatus.MATCHING_COMPLETE: 'MATCHING_COMPLETE',
  MatchingStatus.MATCHING_CANCEL: 'MATCHING_CANCEL',
};
