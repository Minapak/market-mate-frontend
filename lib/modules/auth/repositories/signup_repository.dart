import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/auth/models/signup_model.dart';
import 'package:sip_app/modules/common/models/response_success_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';

part 'signup_repository.g.dart';

@RestApi()
abstract class SignupRepository {
  factory SignupRepository(Dio dio, {String baseUrl}) = _SignupRepository;

  // identykey check api
  @GET('/identyKey/{identyKey}')
  Future<ResponseModel<ResponseSuccessModel>> checkIdentyKey({
    @Path() required String identyKey,
  });

  @POST('/signup')
  Future<ResponseModel<MemberModel>> signup({
    @Body() required SignupModel data,
  });
}
