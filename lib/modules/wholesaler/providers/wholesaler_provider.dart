import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_model.dart';
import 'package:sip_app/modules/wholesaler/models/wholesaler_pagination_params.dart';
import 'package:sip_app/modules/wholesaler/repositories/wholesaler_repository.dart';

class CategoryPair {
  final int mainCategoryId;
  final int middleCategoryId;

  CategoryPair({required this.mainCategoryId, required this.middleCategoryId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryPair &&
        other.mainCategoryId == mainCategoryId &&
        other.middleCategoryId == middleCategoryId;
  }

  @override
  int get hashCode => mainCategoryId.hashCode ^ middleCategoryId.hashCode;
}

final wholesalerListProvider = StateNotifierProvider.family<wholesalerStateNotifier,
    PaginationBase, CategoryPair>((ref, categoryPair) {
  final Dio dio = Dio();
  final wholesalerRepository repository = wholesalerRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/wholesales');

  final notifier =
  wholesalerStateNotifier(repository: repository, categoryPair: categoryPair);

  return notifier;
});

class wholesalerStateNotifier extends StateNotifier<PaginationBase> {
  final wholesalerRepository repository;
  final CategoryPair categoryPair;

  wholesalerStateNotifier({
    required this.repository,
    required this.categoryPair,
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
// 5가지 가능성
      // State의 상태
      // [상태가]
      // 1) Pagination - 정상적으로 데이터가 있는 상태
      // 2) PaginationLoading - 데이터가 로딩중인 상태 (현재 캐시 없음)
      // 3) PaginationError - 에러가 있는 상태
      // 4) PaginationRefetching - 첫번째 페이지부터 다시 데이터를 가져올때
      // 5) PaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을때

      // 바로 반환하는 상황
      // 1) hasMore = false (기존 상태에서 이미 다음 데이터가 없다는 값을 들고있다면)
      // 2) 로딩중 - fetchMore: true
      //    fetchMore가 아닐때 - 새로고침의 의도가 없다

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
      wholesalerPaginationParams paginationParams = wholesalerPaginationParams(
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
      //fetchMore
      //데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as Pagination<wholesalerModel>;

        state = PaginationFetchingMore<wholesalerModel>(
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

      final res = await repository.paginate(paginationParams: paginationParams);

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
