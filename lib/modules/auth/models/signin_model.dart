
import 'package:json_annotation/json_annotation.dart';

part 'signin_model.g.dart';


/// SigninModel 클래스는 사용자의 로그인 정보를 표현하고,
/// JSON과 Dart 객체 간의 변환을 쉽게 할 수 있도록 도와줍니다.
@JsonSerializable()
class SigninModel {
  //identyKey: 사용자의 아이디 또는 식별 키를 나타내는 문자열
  //password: 사용자의 비밀번호를 나타내는 문자열
  final String identyKey;
  final String password;

  SigninModel({required this.identyKey, required this.password});

  factory SigninModel.fromJson(Map<String, dynamic> json) => _$SigninModelFromJson(json);

  Map<String, dynamic> toJson() => _$SigninModelToJson(this);
}