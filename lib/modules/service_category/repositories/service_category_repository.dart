import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/service_category/models/service_categories_pagination_params.dart';
import 'package:sip_app/modules/service_category/models/service_category_model.dart';

part 'service_category_repository.g.dart';

@RestApi()
abstract class ServiceCategoryRepository {
  factory ServiceCategoryRepository(Dio dio, {String baseUrl}) = _ServiceCategoryRepository;

  // 서비스 카테고리 목록 불러오기
  @GET('/service_categories')
  Future<ResponseModel<Pagination<ServiceCategoryModel>>> paginate({
    @Queries() ServiceCategoriesPaginationParams? paginationParams =
    const ServiceCategoriesPaginationParams()
});
}
