import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/faq/models/faq_model.dart';
import 'package:sip_app/modules/faq/models/faqs_pagination_params.dart';

part 'faq_repository.g.dart';

@RestApi()
abstract class FaqRepository {
  factory FaqRepository(Dio dio, {String baseUrl}) = _FaqRepository;

  // faq 페이지네이션
  @GET('/faqs')
  Future<ResponseModel<Pagination<FaqModel>>> faqPaginate({
    @Queries() FaqsPaginationParams? paginationParams =
    const FaqsPaginationParams()
  });
}
