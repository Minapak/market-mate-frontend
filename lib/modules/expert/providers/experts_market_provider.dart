import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/expert/models/experts_pagination_params.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';
import 'package:sip_app/modules/market/repositories/market_repository.dart';

class MarketCategory {
  final int marketId;

  MarketCategory({required this.marketId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketCategory &&
        other.marketId == marketId;
  }

  @override
  int get hashCode => marketId.hashCode;
}

final expertMarketListProvider = StateNotifierProvider.family<ExpertsMarketStateNotifier,
    PaginationBase, MarketCategory>((ref, categoryPair) {
  final Dio dio = Dio();
  final MarketRepository repository = MarketRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/markets');

  final notifier =
  ExpertsMarketStateNotifier(repository: repository,marketCategory: categoryPair);

  return notifier;
});

class ExpertsMarketStateNotifier extends StateNotifier<PaginationBase> {
  final MarketRepository repository;
  final MarketCategory marketCategory;

  ExpertsMarketStateNotifier({
    required this.repository,
    required this.marketCategory,
  }) : super(PaginationLoading()) {
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

      // 2번 반환 상황
      if (fetchMore && (isLoading || isReFetching || isFetchingMore)) {
        return;
      }

      // param 생성
      ExpertsPaginationParams paginationParams = ExpertsPaginationParams(
        limit: fetchCount,
        page: page,
      );
      print("marketCategory?:"+marketCategory.marketId.toString());

      // if (marketCategory.marketId > 0) {
      //   paginationParams = paginationParams.copyWith(
      //       mainCategoryId: 0,
      //       subCategoryId: 0,
      //       marketId: marketCategory.marketId);
      // }

      //fetchMore
      //데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as Pagination<ExpertModel>;

        state = PaginationFetchingMore<ExpertModel>(
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
          state = PaginationLoading();
        }
      }

      final res = await repository.getMarketsExpertPagenate(id: marketCategory.marketId,paginationParams: paginationParams);

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
      state = PaginationError(message: "데이터를 불러오지 못했습니다");
    }
  }
}
