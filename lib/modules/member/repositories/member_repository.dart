import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/community/models/community_model.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/common/models/image_response_model.dart';
import 'package:sip_app/modules/common/models/response_model.dart';
import 'package:sip_app/modules/member/models/member_model.dart';
import 'package:sip_app/modules/wishlist/models/wishlist_model.dart';

part 'member_repository.g.dart';



@RestApi()
abstract class MemberRepository {
  factory MemberRepository(Dio dio, {String baseUrl}) = _MemberRepository;


  // 내 정보 디테일 보기
  @GET('/{id}')
  Future<ResponseModel<MemberModel>> getMember({
    @Path() required String id,

  });

  // 내 리뷰 목록보기
  @GET('/{id}/reviews/experts')
  Future<ResponseModel<Pagination<ReviewModel>>> paginateReviews({
    @Queries()
        BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });

  // 내 찜한 전문가 목록보기
  @GET('/{id}/wishlists/experts')
  Future<ResponseModel<Pagination<WishlistModel>>> paginateWishlists({
    @Queries()
        BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });

  // 내 커뮤니티 글 목록보기
  @GET('/{id}/communities')
  Future<ResponseModel<Pagination<CommunityModel>>> paginateCommunities({
    @Queries()
        BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });

  // 내 댓글 목록보기
  @GET('/{id}/communities/comments')
  Future<ResponseModel<Pagination<CommunityModel>>> paginateComments({
    @Queries()
        BasicPaginationParams paginationParams = const BasicPaginationParams(),
    @Path() required String id,
  });

  // 멤버 썸네일 수정
  @PUT('/{id}/image')
  @MultiPart()
  Future<ResponseModel<ImageResponseModel>> updateImage({
    @Path() required String id,
    @Part() required File image,
  });

  // 맴버 정보 수정
  @PUT('/{id}')
  Future<ResponseModel<MemberModel>> updateMember({
    @Path() required String id,
    @Body() required UpdateMemberModel data,
  });

  // 리뷰 삭제
  @DELETE('/{userId}/reviews/{reviewId}')
  Future<ResponseModel<String>> deleteReview({
    @Path() required String userId,
    @Path() required int reviewId,
  });
}
