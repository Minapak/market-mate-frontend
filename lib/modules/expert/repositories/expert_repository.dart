import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/expert/models/experts_pagination_params.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/wishlist/models/create_wishlist_model.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';
import 'package:sip_app/modules/wishlist/models/wishlist_model.dart';

part 'expert_repository.g.dart';

@RestApi()
abstract class ExpertRepository {
  factory ExpertRepository(Dio dio, {String baseUrl}) = _ExpertRepository;

  @GET('/')
  Future<ResponseModel<Pagination<ExpertModel>>> paginate(
      {
        @Queries() ExpertsPaginationParams? paginationParams =
        const ExpertsPaginationParams()
      });

  @GET('/{id}')
  Future<ResponseModel<ExpertModel>> getDetail({
    @Path() required int id,
  });

  @GET('/{id}/reviews')
  Future<ResponseModel<Pagination<ReviewModel>>> reviewPaginate({
    @Queries()
    BasicPaginationParams? paginationParams = const BasicPaginationParams(),
    @Path() required int id,
  });

  // 전문가 찜하기
  @POST('/experts/{expertId}/wishlists')
  Future<ResponseModel<WishlistModel>> createWishlist({
    @Path('expertId') required int expertId,
    @Body() required CreateWishlistModel data,
  });

  //찜하기 삭제
  @DELETE('/{userId}/experts/wishlists/{wishlistId}')
  Future<ResponseModel<bool>> deleteWishlist({
    @Path('userId') required String userId,
    @Path('wishlistId') required int wishlistId,
  });

  @GET('/{userId}/experts/{expertId}/wishlist')
  Future<ResponseModel<ResponseCheckWishModel>> checkUserWish({
    @Path('userId') required String userId,
    @Path('expertId') required int expertId,
  });
}

