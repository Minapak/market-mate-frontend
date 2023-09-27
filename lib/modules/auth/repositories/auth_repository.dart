import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/auth/models/auth_token_model.dart';
import 'package:sip_app/modules/auth/models/signin_model.dart';
import 'package:sip_app/modules/auth/models/signup_model.dart';
import 'package:sip_app/modules/common/models/response_success_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';

part 'auth_repository.g.dart';

@RestApi()
abstract class AuthRepository {
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