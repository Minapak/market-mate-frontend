import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/matching/models/create_matching_model.dart';
import 'package:sip_app/modules/matching/models/create_matching_ws_model.dart';
import 'package:sip_app/modules/matching/models/matching_ws_model.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';

part 'matching_repository.g.dart';

@RestApi()
abstract class MatchingRepository {
  factory MatchingRepository(Dio dio, {String baseUrl}) = _MatchingRepository;

  @GET('/{id}/matchings')
  Future<ResponseModel<Pagination<MatchingModel>>> paginate({
    @Queries()
        BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });

  @GET('experts/{id}/matchings')
  Future<ResponseModel<Pagination<MatchingModel>>> paginateExpertMatchings({
    @Queries()
    BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required int id,
  });

  @GET('wholesaler/{id}/matchings')
  Future<ResponseModel<Pagination<MatchingModel>>> paginatewholesalerMatchings({
    @Queries()
    BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required int id,
  });

  @POST('/users/matchings')
  Future<ResponseModel<MatchingModel>> createMatching({
    @Body() required CreateMatchingModel data
  });

  @POST('/wholesaler/matchings')
  Future<ResponseModel<MatchingWSModel>> createWSMatching({
    @Body() required CreateMatchingWSModel data
  });
}
