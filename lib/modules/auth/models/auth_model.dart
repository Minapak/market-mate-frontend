// JSON 직렬화를 위한 주요 기능들을 제공하는 패키지
import 'package:json_annotation/json_annotation.dart';

// part 'auth_model.g.dart';: 코드 생성기에게 해당 클래스의 직렬화 및 역직렬화 코드를 생성하도록 알려주는 부분
// auth_model.g.dart 파일은 자동으로 생성
part 'auth_model.g.dart';

/// 사용자 역할을 나타내는 열거형(enum) UserRole을 정의
enum UserRole { ROLE_ADMIN, ROLE_PREPARE_MEMBER, ROLE_NORMAL_MEMBER }

/// JsonConverter를 구현한 클래스로,
/// UserRole 열거형 값을 JSON 문자열로 변환하고
/// 역으로 JSON 문자열을 UserRole 열거형으로 변환
class UserRoleConverter implements JsonConverter<UserRole, String> {
  const UserRoleConverter();

  UserRole fromJson(String json) {
    return UserRole.values.firstWhere((e) => e.toString() == 'UserRole.$json');
  }

  String toJson(UserRole object) {
    return object.toString().split('.').last;
  }
}
//  해당 클래스가 JSON 직렬화와 관련된 어노테이션을 사용할 것임을 나타냄
@JsonSerializable()
//JSON 직렬화를 위한 모델 클래스를 정의
/// 어노테이션은 role 필드에 대한 역할 변환을 적용함을 나타냄
class AuthModel {
  final String? identyKey;
  final String? userUUID;
  @UserRoleConverter()
  final UserRole? role;

  AuthModel({
    this.identyKey,
    this.userUUID,
    this.role,
  });
///생성자와 copyWith 메서드를 정의하여 객체의 복제 또는 수정을 쉽게 할 수 있도록 합니다.
  AuthModel copyWith(
      {String? accessToken,
      String? xerk,
      String? identyKey,
      String? userUUID,
      UserRole? role}) {
    return AuthModel(
        identyKey: identyKey ?? this.identyKey,
        userUUID: userUUID ?? this.userUUID,
        role: role ?? this.role);
  }
// factory 생성자를 통해 JSON 데이터를 사용하여 객체를 생성
  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
// toJson 메서드를 통해 객체를 JSON 형태로 변환
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
