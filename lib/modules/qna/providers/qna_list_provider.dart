import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/qna/models/qna_model.dart';
import 'package:sip_app/modules/qna/repositories/qna_repository.dart';

final QnaListStateNotifierProvider = StateNotifierProvider
<QnaListStateNotifier, PaginationBase>((ref) {
  final Dio dio = Dio();
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
  "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJhdXRoIjoiUk9MRV9BRE1JTiIsInVzZXJVVUlEIjoiMmM5ZTgxYTk4ODc5YjNlMTAxODg3OWI1MzI5ZTAwMDAiLCJpZGVudHlLZXkiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJleHAiOjE2OTM1MjA2ODN9.M_vLns1fietL0m9VhhEuvQr7_9asmZioK7L3uRVNQSAik1vPrrjf3VBOChMo9iTUfyjT7nsu0fs-8HJY4-9KbA";
  final QnaRepository repository = QnaRepository(dio, baseUrl:'$SERVER_BASE_URL/users/');
  final userUUID = ref.watch(memberUUIDProvider);
  print(userUUID);
  final notifier = QnaListStateNotifier(userUUID:userUUID, repository: repository);

  return notifier;
});

class QnaListStateNotifier extends StateNotifier<PaginationBase> {
  final String userUUID;
  final QnaRepository repository;

  QnaListStateNotifier({required this.userUUID, required this.repository}): super(PaginationLoading()){
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 5,
    int page = 1,
    bool fetchMore = false, // 추가 데이터 요청
    bool forceRefetch = false, // 강제로 처음부터 로딩
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

      BasicPaginationParams paginationParams = BasicPaginationParams(
        limit: fetchCount,
        page: page,
      );

      if (fetchMore) {
        final pState = state as Pagination<QnaModel>;

        state = PaginationFetchingMore<QnaModel>(
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

      final res = await repository.qnaPaginate(
          id: userUUID,
          paginationParams: paginationParams
      );

      if (state is PaginationFetchingMore) {
        final pState = state as PaginationFetchingMore;

        state = res.response.copyWith(content: [
          ...pState.content,
          ...res.response.content,
        ]);
      } else {
        state = res.response;
      }
    } catch(error) {
      print(error);
      state = PaginationError(message: "데이터를 불러오지 못했습니다");
    }
  }
}