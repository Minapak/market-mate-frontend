// part 'home.api.g.dart';
//Retrofit 라이브러리의 @RestApi 어노테이션을 사용을 위한 패키지
import 'package:retrofit/retrofit.dart';
// Dio HTTP 클라이언트 라이브러리를 사용을 위한 패키지
import 'package:dio/dio.dart';
//API 호출에 필요한 경로 상수를 정의하는 path.dart 파일을 임포트
import 'package:sip_app/constants/path.dart';
//API 응답을 처리하기 위한 ResponseModel 클래스를 임포트
import 'package:sip_app/modules/common/models/response_model.dart';
//메인 데이터를 담는 MainModel 클래스를 임포트
import 'package:sip_app/modules/main/models/main_model.dart';
// Retrofit 코드 생성기에게 해당 클래스의 API 호출 코드를 생성하도록 알려주는 부분입니다.
// _MainRepository 클래스는 자동으로 생성되며, 실제 API 호출에 대한 코드가 들어갑니다.
part 'main_repository.g.dart';

@RestApi()
abstract class MainRepository {
  // MainRepository 클래스의 팩토리 생성자를 정의
  // 이 생성자를 통해 Retrofit을 초기화하고, _MainRepository 클래스의 인스턴스를 생성
  factory MainRepository(Dio dio, {String? baseUrl}) = _MainRepository;
  // getMainData 메서드는 HTTP GET 요청을 생성하는데 사용
  // @GET 어노테이션은 해당 메서드가 GET 요청을 정의한다는 것을 나타내며,
  // /main 경로에 대한 요청을 정의
  // 응답은 ResponseModel<MainModel> 형태로 예상되며, MainModel 클래스는 메인 데이터의 형식을 나타냄
  @GET('/main')
  Future<ResponseModel<MainModel>> getMainData();
}
