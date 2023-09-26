import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';

part 'service_center_repository.g.dart';

@RestApi()
abstract class ServiceCenterRepository {
  factory ServiceCenterRepository(Dio dio, {String baseUrl}) = _ServiceCenterRepository;

  @GET('/{id}/qnas')
  Future<ResponseModel> getMyQnas({
    @Queries() BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });

  @GET('/{id}/faqs')
  Future<ResponseModel> getMyFaqs({
    @Queries() BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });
}
