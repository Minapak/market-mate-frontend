import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/auth/models/auth_token_model.dart';
import 'package:sip_app/modules/auth/models/signin_model.dart';
import 'package:sip_app/modules/auth/models/signup_model.dart';
import 'package:sip_app/modules/common/models/response_success_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';

part 'auth_repository.g.dart';

/// Retrofit을 사용하여 Dio를 통해
/// RESTful API를 호출하는
/// AuthRepository 클래스를 정의하는 코드
@RestApi()

// 이 클래스는 Retrofit을 통해 생성될 실제 클래스의 원형
abstract class AuthRepository {
  //AuthRepository의 팩토리 생성자
  //Dio 인스턴스와 선택적인 baseUrl을 인자로 받습니다.
  //이 생성자를 통해 _AuthRepository 클래스의 인스턴스를 생성
  factory AuthRepository(Dio dio, {String baseUrl}) = _AuthRepository;

  // identykey check api
  @GET('/identyKey/{identyKey}')
  Future<ResponseModel<ResponseSuccessModel>> checkIdentyKey({
    @Path() required String identyKey,
  });

  @POST('/signup')
  Future<ResponseModel<MemberModel>> signup({
    @Body() required SignupModel data,
  });

  @POST('/auth')
  Future<ResponseModel<AuthTokenModel>> signin({
    @Body() required SigninModel data,
  });

  @PUT('/auth')
  Future<ResponseModel<AuthTokenModel>> refreshToken();
}
