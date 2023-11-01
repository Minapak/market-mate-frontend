// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_register_expert_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseRegisterExpertModel _$ResponseRegisterExpertModelFromJson(
        Map<String, dynamic> json) =>
    ResponseRegisterExpertModel(
      RegiType: $enumDecode(_$ExpertRegisterTypeEnumMap, json['regiType']),
    );

Map<String, dynamic> _$ResponseRegisterExpertModelToJson(
    ResponseRegisterExpertModel instance) =>
    <String, dynamic>{
      'RegiType': _$ExpertRegisterTypeEnumMap[instance.RegiType]!,
    };

const _$ExpertRegisterTypeEnumMap = {
  ExpertRegisterType.ID: 'ID',
  ExpertRegisterType.THUMBNAIL: 'THUMBNAIL',
  ExpertRegisterType.INTRODUCE_EXPERT: 'INTRODUCE_EXPERT',
  ExpertRegisterType.INTRODUCE_CONTENT: 'INTRODUCE_CONTENT',
  ExpertRegisterType.MAIN_CATEGORIES: 'MAIN_CATEGORIES',
  ExpertRegisterType.MIDDLE_CATEGORIES: 'MIDDLE_CATEGORIES',
};