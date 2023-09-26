import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/review/models/review_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';

final myReviewsProvider =
    StateNotifierProvider<ReviewsStateNotifier, PaginationBase>((ref) {
  final Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJhdXRoIjoiUk9MRV9BRE1JTiIsInVzZXJVVUlEIjoiMmM5ZTgxYTk4ODc5YjNlMTAxODg3OWI1MzI5ZTAwMDAiLCJpZGVudHlLZXkiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJleHAiOjE2OTMyNjAyOTR9.bvtcDfqWf6Zf9XmYHTNxWUAgM2igePwBlgEtO_eqh_0GvpaGCUFdibNKfD7lCWwmc1_987qAZmFRF8XUw6ow9w";
  final MemberRepository repository =
      MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/users/');
  final authModel = ref.watch(authProvider);
  final notifier = ReviewsStateNotifier(
      repository: repository, userUUID: authModel.userUUID ?? '');

  return notifier;
});

class ReviewsStateNotifier extends StateNotifier<PaginationBase> {
  final MemberRepository repository;
  final String userUUID;

  ReviewsStateNotifier({required this.repository, required this.userUUID})
      : super(PaginationLoading()) {
    paginate();
  }

  void deleteReview(int reviewId) {
    if (state is Pagination<ReviewModel>) {
      final pState = state as Pagination<ReviewModel>;
      state = Pagination<ReviewModel>(
        content: pState.content.where((item) => item.id != reviewId).toList(),
        hasMore: pState.hasMore,
        totalElements: pState.totalElements - 1,
        totalPages: pState.totalPages,
      );
    } else if (state is PaginationFetchingMore<ReviewModel>) {
      final pState = state as PaginationFetchingMore<ReviewModel>;
      state = PaginationFetchingMore<ReviewModel>(
        content: pState.content.where((item) => item.id != reviewId).toList(),
        hasMore: pState.hasMore,
        totalElements: pState.totalElements - 1,
        totalPages: pState.totalPages,
      );
    }
  }

  Future<void> paginate({
    int fetchCount = 5,
    int page = 1,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is Pagination && !forceRefetch) {
        final pState = state as Pagination;

        if (!pState.hasMore) {
          return;
        }
      }

      final bool isLoading = state is PaginationLoading;
      final bool isReFetching = state is PaginationRefetching;
      final bool isFetchingMore = state is PaginationFetchingMore;

      if (fetchMore && (isLoading || isReFetching || isFetchingMore)) {
        return;
      }

      // param 생성
      BasicPaginationParams paginationParams = BasicPaginationParams(
        limit: fetchCount,
        page: page,
      );

      if (fetchMore) {
        final pState = state as Pagination<ReviewModel>;

        state = PaginationFetchingMore<ReviewModel>(
            content: [...pState.content],
            hasMore: pState.hasMore,
            totalElements: pState.totalElements,
            totalPages: pState.totalPages);

        paginationParams = paginationParams.copyWith(
          limit: fetchCount,
          page: page,
        );
      } else {
        if (state is Pagination && !forceRefetch) {
          final pState = state as Pagination;

          state = PaginationRefetching(
              hasMore: pState.hasMore,
              totalPages: pState.totalPages,
              totalElements: pState.totalElements,
              content: pState.content);
        } else {
          // 나머지 상황
          state = PaginationLoading();
        }
      }

      final res = await repository.paginateReviews(
          id: userUUID, paginationParams: paginationParams);

      print(res);
      if (state is PaginationFetchingMore) {
        final pState = state as PaginationFetchingMore;

        state = res.response.copyWith(content: [
          ...pState.content,
          ...res.response.content,
        ]);
      } else {
        state = res.response;
      }
    } catch (error) {
      print(error);
      state = PaginationError(message: '에러입니다');
    }
  }
}
