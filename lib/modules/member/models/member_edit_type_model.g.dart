// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_edit_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberEditTypeModel _$MemberEditTypeModelFromJson(Map<String, dynamic> json) =>
    MemberEditTypeModel(
      editType: $enumDecode(_$MemberEditTypeEnumMap, json['editType']),
    );

Map<String, dynamic> _$MemberEditTypeModelToJson(
        MemberEditTypeModel instance) =>
    <String, dynamic>{
      'editType': _$MemberEditTypeEnumMap[instance.editType]!,
    };

const _$MemberEditTypeEnumMap = {
  MemberEditType.NICKNAME: 'NICKNAME',
  MemberEditType.PASSWORD: 'PASSWORD',
  MemberEditType.PHONE: 'PHONE',
  MemberEditType.WITHDRAW: 'WITHDRAW',
  MemberEditType.THUMBNAIL: 'THUMBNAIL',
  MemberEditType.NONE: 'NONE',
};
