import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/expert/models/experts_pagination_params.dart';
import 'package:sip_app/modules/market/models/market_model.dart';
import 'package:sip_app/modules/market/repositories/market_repository.dart';

import '../../expert/providers/experts_provider.dart';

final marketListNotifierProvider = StateNotifierProvider.family
  <MarketListStateNotifier, PaginationBase, CategoryPair>((ref, categoryPair) {
    final Dio dio = Dio();
    final MarketRepository repository = MarketRepository(dio, baseUrl: "$SERVER_BASE_URL/users/markets");
    final notifier = MarketListStateNotifier(repository: repository, categoryPair: categoryPair);

    return notifier;
});

class MarketListStateNotifier extends StateNotifier<PaginationBase> {
  final MarketRepository repository;
  final CategoryPair categoryPair;

  MarketListStateNotifier({required this.repository, required this.categoryPair})
    : super(PaginationLoading()){
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

      ExpertsPaginationParams paginationParams = ExpertsPaginationParams(
        limit: fetchCount,
        page: page,
      );

      if (categoryPair.mainCategoryId > 0) {
        paginationParams = paginationParams.copyWith(
            mainCategoryId: categoryPair.mainCategoryId);
      }

      if (categoryPair.middleCategoryId > 0) {
        paginationParams = paginationParams.copyWith(
            subCategoryId: categoryPair.middleCategoryId);
      }

      if (fetchMore) {
        final pState = state as Pagination<MarketModel>;

        state = PaginationFetchingMore<MarketModel>(
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

      final res = await repository.paginate(paginationParams: paginationParams);
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

    } catch(error) {
      print('erererer');
      print(error);
      state = PaginationError(message: "서버 에러");
    }
  }
}