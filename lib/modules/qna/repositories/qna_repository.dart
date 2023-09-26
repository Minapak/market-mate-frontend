import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/qna/models/qna_model.dart';

part 'qna_repository.g.dart';

@RestApi()
abstract class QnaRepository {
  factory QnaRepository(Dio dio, {String baseUrl}) = _QnaRepository;

  @GET('/{id}/qnas')
  Future<ResponseModel<Pagination<QnaModel>>> qnaPaginate({
    @Queries() BasicPaginationParams? paginationParams =
    const BasicPaginationParams(),
    @Path() required String id,
  });
}