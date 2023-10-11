// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mypage_edit_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MypageEditTypeModel _$MypageEditTypeModelFromJson(Map<String, dynamic> json) =>
    MypageEditTypeModel(
      editType: $enumDecode(_$MypageEditTypeEnumMap, json['editType']),
    );

Map<String, dynamic> _$MypageEditTypeModelToJson(
    MypageEditTypeModel instance) =>
    <String, dynamic>{
      'editType': _$MypageEditTypeEnumMap[instance.editType]!,
    };

const _$MypageEditTypeEnumMap = {
  MypageEditType.NICKNAME: 'NICKNAME',
  MypageEditType.PASSWORD: 'PASSWORD',
  MypageEditType.PHONE: 'PHONE',
  MypageEditType.WITHDRAW: 'WITHDRAW',
  MypageEditType.THUMBNAIL: 'THUMBNAIL',
  MypageEditType.NONE: 'NONE',
};
