import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/category/models/categories_response_model.dart';
import 'package:sip_app/modules/category/models/middle_category_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';

part 'category_repository.g.dart';

@RestApi()
abstract class CategoryRepository {
  factory CategoryRepository(Dio dio, {String baseUrl}) = _CategoryRepository;

  @GET('/')
  Future<ResponseModel<CategoriesResponseModel>> getCategories();

  @GET('/{id}')
  Future<ResponseModel<List<MiddleCategoryModel>>> getMiddleCategories({
    @Path() required int id,
  });
}
