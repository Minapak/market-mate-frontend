import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  final String uuid;
  final String identyKey;
  final String name;
  final String nickname;
  final String phone;
  final String? thumbnail;
  final bool? activate;

  MemberModel(
      {required this.uuid,
      required this.identyKey,
      required this.name,
      required this.nickname,
      required this.phone,
      this.thumbnail,
      this.activate});

  MemberModel copyWith({
    String? nickname,
    String? phone,
    String? thumbnail,
}) {
    return MemberModel(
        uuid: this.uuid,
        identyKey: this.identyKey,
        name: this.name,
        nickname: nickname ?? this.nickname,
        phone: phone ?? this.phone,
        thumbnail:  thumbnail ?? this.thumbnail
    );
  }

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}

@JsonSerializable()
class UpdateMemberModel {
  final bool? activate;
  final String? nickname;
  final String? password;
  final String? passwordVerify;

  UpdateMemberModel({this.activate, this.nickname, this.password, this.passwordVerify});

  factory UpdateMemberModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateMemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMemberModelToJson(this);
}
