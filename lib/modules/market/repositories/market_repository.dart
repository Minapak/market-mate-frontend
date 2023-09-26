import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/expert/models/experts_pagination_params.dart';
import 'package:sip_app/modules/market/models/market_model.dart';

part 'market_repository.g.dart';

@RestApi()
abstract class MarketRepository {
  factory MarketRepository(Dio dio, {String baseUrl}) = _MarketRepository;

  // 시장 전체 목록 보기
  @GET('/')
  Future<ResponseModel<Pagination<MarketModel>>> paginate({
    @Queries() ExpertsPaginationParams? paginationParams =
    const ExpertsPaginationParams()
  });

  // 시장 디테일 보기
  @GET('/{id}')
  Future<ResponseModel<MarketModel>> getMarket({
    @Path() required int id,
  });

}