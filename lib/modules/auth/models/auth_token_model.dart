import 'package:json_annotation/json_annotation.dart';

part 'auth_token_model.g.dart';

///accessToken은 일반적으로 사용자가 로그인 또는 인증한 후,
///인증 서버 또는 백엔드 서버에서 accessToken을 발급
@JsonSerializable()
class AuthTokenModel {

  ///accessToken은 사용자가 로그아웃하거나 인증 세션이 만료될 때 무효화되거나 갱신될 수 있습니다.
  //일반적으로 accessToken은 만료 기간을 가지며,
  //만료 시간이 지나면 재발급 또는 갱신이 필요합니다.
  //이렇게 함으로써 보안을 유지하고 인증 세션의 안전성을 확보할 수 있습니다.
  /// xerk와 같은 보조 토큰은 추가적인 기능을 위해 사용되거나, 보다 복잡한 보안 시나리오에서 활용될 수 있습니다.
  //이러한 토큰은 특정 상황에 따라 발급되고 사용됩니다.
  // 예를 들어, xerk 토큰은 OAuth 2.0에서 리프레시 토큰과 비슷한 역할을 할 수 있습니다.

  final String accessToken;
  final String xerk;

  AuthTokenModel({required this.accessToken, required this.xerk});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) => _$AuthTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthTokenModelToJson(this);
}