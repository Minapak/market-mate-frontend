import 'package:json_annotation/json_annotation.dart';

part 'member_edit_type_model.g.dart';

enum MemberEditType {
  NICKNAME,
  PASSWORD,
  PHONE,
  WITHDRAW,
  THUMBNAIL,
  NONE
}

@JsonSerializable()
class MemberEditTypeModel {
  final MemberEditType editType;

  MemberEditTypeModel({required this.editType});

  factory MemberEditTypeModel.fromJson(Map<String, dynamic> json) =>
      _$MemberEditTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberEditTypeModelToJson(this);
}
