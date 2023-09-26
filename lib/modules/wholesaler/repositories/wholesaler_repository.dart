import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_model.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_pagination_params.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/wishlist/models/create_wishlist_model.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';
import 'package:sip_app/modules/wishlist/models/wishlist_model.dart';

part 'wholesaler_repository.g.dart';

@RestApi()
abstract class wholesalerRepository {
  factory wholesalerRepository(Dio dio, {String baseUrl}) = _wholesalerRepository;

  @GET('/users/wholesaler')
  Future<ResponseModel<Pagination<wholesalerModel>>> paginate(
      {
        @Queries() wholesalerPaginationParams? paginationParams =
        const wholesalerPaginationParams()
      });

  @GET('/users/wholesale/{wholesaleId}')
  Future<ResponseModel<wholesalerModel>> getDetail({
    @Path() required int id,
  });

  @GET(' /users/wholesale/{wholesaleId}/reviews')
  Future<ResponseModel<Pagination<ReviewModel>>> reviewPaginate({
    @Queries()
    BasicPaginationParams? paginationParams = const BasicPaginationParams(),
    @Path() required int id,
  });

  // 전문가 찜하기
  @POST(' /users/wholesale/{wholesaleId}/wishlists')
  Future<ResponseModel<WishlistModel>> createWishlist({
    @Path('wholesalerId') required int wholesalerId,
    @Body() required CreateWishlistModel data,
  });

  //찜하기 삭제
  @DELETE('/{userId}/wholesaler/wishlists/{wishlistId}')
  Future<ResponseModel<bool>> deleteWishlist({
    @Path('userId') required String userId,
    @Path('wishlistId') required int wishlistId,
  });

  @GET('/{userId}/wholesaler/{wholesalerId}/wishlist')
  Future<ResponseModel<ResponseCheckWishModel>> checkUserWish({
    @Path('userId') required String userId,
    @Path('wholesalerId') required int wholesalerId,
  });
}

