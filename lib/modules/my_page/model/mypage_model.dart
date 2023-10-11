import 'package:json_annotation/json_annotation.dart';

part 'mypage_model.g.dart';

@JsonSerializable()
class MypageModel {
  final String uuid;
  final String identyKey;
  final String name;
  final String nickname;
  final String phone;
  final String? thumbnail;
  final bool? activate;

  MypageModel(
      {required this.uuid,
      required this.identyKey,
      required this.name,
      required this.nickname,
      required this.phone,
      this.thumbnail,
      this.activate});

  MypageModel copyWith({
    String? nickname,
    String? phone,
    String? thumbnail,
}) {
    return MypageModel(
        uuid: this.uuid,
        identyKey: this.identyKey,
        name: this.name,
        nickname: nickname ?? this.nickname,
        phone: phone ?? this.phone,
        thumbnail:  thumbnail ?? this.thumbnail
    );
  }

  factory MypageModel.fromJson(Map<String, dynamic> json) =>
      _$MypageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MypageModelToJson(this);
}

@JsonSerializable()
class UpdateMypageModel {
  final bool? activate;
  final String? nickname;
  final String? password;
  final String? passwordVerify;

  UpdateMypageModel({this.activate, this.nickname, this.password, this.passwordVerify});

  factory UpdateMypageModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateMypageModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateMypageModelToJson(this);
}
