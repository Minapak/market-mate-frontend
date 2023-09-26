///JWT (JSON Web Token) 문자열을 파싱하여 사용자 인증 정보를 추출하는 함수와 관련된 코드입니다.
///JWT는 인증 정보를 안전하게 전달하기 위해 사용되는 토큰 기반의 인증 방식

// JSON 디코딩 및 문자열 인코딩을 위한 기능을 제공
import 'dart:convert';
// 사용자 인증 정보를 나타내는 모델 클래스
import 'package:sip_app/modules/auth/models/auth_model.dart';

// 주어진 JWT 문자열을 파싱하여 AuthModel 객체를 생성하는 함수
// 함수는 JWT의 payload 부분을 디코딩하고 필요한 정보를 추출하여 AuthModel 객체를 생성하고 반환
AuthModel parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('Invalid payload');
  }

  final UserRoleConverter converter = UserRoleConverter();
  final AuthModel authModel = AuthModel(
      identyKey: payloadMap['identyKey'],
      role: converter.fromJson(payloadMap['auth']),
      userUUID: payloadMap['userUUID']);

  return authModel;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
