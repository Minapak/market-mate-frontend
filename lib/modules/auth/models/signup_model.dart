import 'package:json_annotation/json_annotation.dart';

part 'signup_model.g.dart';

@JsonSerializable()
class SignupModel {
  final String name;
  final String nickname;
  final String identyKey;
  final String password;
  final String phone;
  final bool activate;

  SignupModel({
    required this.name,
    required this.nickname,
    required this.identyKey,
    required this.password,
    required this.phone,
    required this.activate,
  });

  SignupModel copyWith({
   String? name,
   String? nickname,
   String? identyKey,
   String? password,
   String? phone,
   bool? activate,
  }) {
    return SignupModel(
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      identyKey: identyKey ?? this.identyKey,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      activate: activate ?? this.activate,
    );
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) =>_$SignupModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignupModelToJson(this);
}