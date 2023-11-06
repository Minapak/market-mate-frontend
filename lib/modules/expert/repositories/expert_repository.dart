
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/expert/models/expert_register_model.dart';
import 'package:sip_app/modules/expert/models/experts_pagination_params.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/wishlist/models/create_wishlist_model.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';
import 'package:sip_app/modules/wishlist/models/wishlist_model.dart';

import '../../common/models/image_model.dart';
import '../../common/models/image_response_model.dart';

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
  //전문가 찜하기 가져오기
  @GET('/{userId}/experts/{expertId}/wishlist')
  Future<ResponseModel<ResponseCheckWishModel>> checkUserWish({
    @Path('userId') required String userId,
    @Path('expertId') required int expertId,
  });
  /*
  // 전문가 등록 시 thumbnail
  // 추가할것
  */
  // 멤버 썸네일 수정
  @PUT('/users/experts/{expertId}/thumbnail')
  @MultiPart()
  Future<ResponseModel<ImageResponseModel>> updateImage({
    @Path() required String id,
    @Part() required File image,
  });

  @PUT('/users/experts/{expertId}/thumbnail')
  @MultiPart()
  Future<ResponseModel<ExpertRegisterModel>> ExpertsUploadthumbnail({
    @Path('expertId') required int id,
    @Part() required File image,
  });
  // 전문가 등록 시 이미지 업로드
  @PUT('/users/experts/{expertId}/images')
  @MultiPart()
  Future<ResponseModel<ExpertRegisterModel>> ExpertsUploadImage({
    @Path('expertId') required int id,
    @Body() required List<XFile> images,
  });

  // 전문가 등록 시 디테일 (id, thumnail, introduceExpert, introduceContent)
  @PUT('/users/experts/{expertId}/images')
  @MultiPart()
  Future<ResponseModel<ExpertRegisterModel>> ExpertsUploadDetail({
    @Path('expertId') required int id,
    @Part() required File thumnail,
    @Path() required String introduceExpert,
    @Path() required String introduceContent,
  });

  // 전문가 전체 등록
  @PUT('/users/{userId}/expert')
  @MultiPart()
  Future<ResponseModel<ExpertRegisterModel>> ExpertsRegister({
    @Path() required int id,
    @Body() required ExpertRegisterModel data,
  });
}

