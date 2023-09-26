import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// 주어진 코드는 flutter_secure_storage 패키지를 사용하여
// 안전한 방식으로 데이터를 저장하고 검색하는 AuthService 클래스를 정의
// 이 클래스는 사용자의 인증 토큰 및 기타 데이터를 안전하게 저장하고 검색하는 역할 수행

/// 사용자의 인증 토큰 및 데이터를 저장하고 검색하는 역할을 하는 서비스 클래스
class AuthService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ///사용자의 인증 토큰을 받아서 'accessToken' 키로 해당 토큰을 안전한 저장소에
  ///******저장하는 비동기 메서드
  Future<void> saveToken(String token) async {
    await secureStorage.write(key: 'accessToken', value: token);
  }
  ///사용자의 'xerk' 데이터를 받아서 'xerk' 키로 해당 데이터를 안전한 저장소에
  ///******저장하는 비동기 메서드
  Future<void> saveXerk(String token) async {
    await secureStorage.write(key: 'xerk', value: token);
  }
  /// 'accessToken' 키를 사용하여 저장소에서 저장된 사용자 인증 토큰을 검색하는 비동기 메서드
  /// 결과는 문자열로 반환되며, 토큰이 저장되지 않았을 경우 null을 반환
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'accessToken');
  }
  /// xerk' 키를 사용하여 저장소에서 저장된 'xerk' 데이터를 검색하는 비동기 메서드
  /// 결과는 문자열로 반환되며, 데이터가 저장되지 않았을 경우 null을 반환
  Future<String?> getXerk() async {
    return await secureStorage.read(key: 'xerk');
  }
}
