import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/community/models/comment_model.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';

final myCommentListProvider =
    StateNotifierProvider<MyCommentsStateNotifier, PaginationBase>((ref) {
  final Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
      "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJhdXRoIjoiUk9MRV9BRE1JTiIsInVzZXJVVUlEIjoiMmM5ZTgxYTk4ODc5YjNlMTAxODg3OWI1MzI5ZTAwMDAiLCJpZGVudHlLZXkiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJleHAiOjE2OTMxNzk2ODh9.JycZI7F-HwWt6G4fdxCHbv5zJ_P2wdmURNBnXPEonD46z-JetFyYDKMbILHfTPZnS3kMFm-AoioPdRwwDTiZ5w";

  final authModel = ref.watch(authProvider);
  final MemberRepository repository =
      MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/users');

  final notifier = MyCommentsStateNotifier(
      repository: repository, userUUID: authModel.userUUID ?? '');

  return notifier;
});

class MyCommentsStateNotifier extends StateNotifier<PaginationBase> {
  final MemberRepository repository;
  final String userUUID;

  MyCommentsStateNotifier({required this.repository, required this.userUUID})
      : super(PaginationLoading()) {
    paginate();
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

      // 2번 반환 상황
      if (fetchMore && (isLoading || isReFetching || isFetchingMore)) {
        return;
      }

      // param 생성
      BasicPaginationParams paginationParams = BasicPaginationParams(
        limit: fetchCount,
        page: page,
      );

      if (fetchMore) {
        final pState = state as Pagination<CommentModel>;

        state = PaginationFetchingMore<CommentModel>(
            content: [...pState.content],
            hasMore: pState.hasMore,
            totalElements: pState.totalElements,
            totalPages: pState.totalPages);

        paginationParams = paginationParams.copyWith(
          limit: fetchCount,
          page: page,
        );
      } else {
        // 데이터를 처음부터 가지고 오는 상황
        // 만약에 데이터가 있는 상황이라면
        // 기존 데이터를 보존한채로 fetch를 진행

        if (state is Pagination && !forceRefetch) {
          final pState = state as Pagination;

          state = PaginationRefetching(
              hasMore: pState.hasMore,
              totalPages: pState.totalPages,
              totalElements: pState.totalElements,
              content: pState.content);
        } else {
          // 나머지 상황
          print('나머지 상황');
          state = PaginationLoading();
        }
      }

      final res = await repository.paginateComments(
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
      state = PaginationError(message: '에러');
    }
  }
}
