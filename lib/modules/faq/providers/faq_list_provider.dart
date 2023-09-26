import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/faq/models/faq_model.dart';
import 'package:sip_app/modules/faq/models/faqs_pagination_params.dart';
import 'package:sip_app/modules/faq/repositories/faq_repository.dart';

final FaqListStateNotifierProvider = StateNotifierProvider.family
  <FaqListStateNotifier, PaginationBase, int>((ref, categoryId) {
    final Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.headers["Authorization"] =
    "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJhdXRoIjoiUk9MRV9BRE1JTiIsInVzZXJVVUlEIjoiMmM5ZTgxYTk4ODc5YjNlMTAxODg3OWI1MzI5ZTAwMDAiLCJpZGVudHlLZXkiOiJ0ZXN0MTg1ZUBuYXZlci5jb20iLCJleHAiOjE2OTM1MjA2ODN9.M_vLns1fietL0m9VhhEuvQr7_9asmZioK7L3uRVNQSAik1vPrrjf3VBOChMo9iTUfyjT7nsu0fs-8HJY4-9KbA";
    final FaqRepository repository = FaqRepository(dio, baseUrl:'$SERVER_BASE_URL/users/');
    final notifier = FaqListStateNotifier(categoryId:categoryId, repository: repository);

    return notifier;
});

class FaqListStateNotifier extends StateNotifier<PaginationBase> {
  final int categoryId;
  final FaqRepository repository;

  FaqListStateNotifier({required this.categoryId,required this.repository}): super(PaginationLoading()){
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

      FaqsPaginationParams paginationParams;

      if (categoryId > 0) {
        paginationParams= FaqsPaginationParams(
          limit: fetchCount,
          page: page,
          categoryId: categoryId,
        );
      } else {
        paginationParams= FaqsPaginationParams(
          limit: fetchCount,
          page: page,
        );
      }

      if (fetchMore) {
        final pState = state as Pagination<FaqModel>;

        state = PaginationFetchingMore<FaqModel>(
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

      final res = await repository.faqPaginate(paginationParams: paginationParams);

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