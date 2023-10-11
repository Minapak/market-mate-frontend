import 'package:json_annotation/json_annotation.dart';

part 'mypage_edit_type_model.g.dart';

enum MypageEditType {
  NICKNAME,
  PASSWORD,
  PHONE,
  WITHDRAW,
  THUMBNAIL,
  NONE
}

@JsonSerializable()
class MypageEditTypeModel {
  final MypageEditType editType;

  MypageEditTypeModel({required this.editType});

  factory MypageEditTypeModel.fromJson(Map<String, dynamic> json) =>
      _$MypageEditTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$MypageEditTypeModelToJson(this);
}
