import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/basic_pagination_params_model.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/wholesaler/repositories/wholesaler_repository.dart';
import 'package:sip_app/modules/review/models/review_model.dart';

final wholesalerReviewsProvider = StateNotifierProvider.family<
    wholesalerReviewsStateNotifier, PaginationBase, int>((ref, id) {
  final Dio dio = Dio();
  final wholesalerRepository repository = wholesalerRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/wholesales/');

  final notifier = wholesalerReviewsStateNotifier(repository: repository, id: id);

  return notifier;
});

class wholesalerReviewsStateNotifier extends StateNotifier<PaginationBase> {
  final wholesalerRepository repository;
  final int id;
  wholesalerReviewsStateNotifier({required this.repository, required this.id})
      : super(PaginationLoading()) {
    paginate(id: id);
  }

  void paginate({
    int id = 0,
    int fetchCount = 5,
    bool fetchMore = false, // 추가 데이터 요청
    bool forceRefetch = false, // 강제로 처음부터 로딩
  }) async {
    try {
      if (id == 0) {
        state = PaginationError(message: "아이디 없음");
        return;
      }

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

      BasicPaginationParams paginationParams =
      BasicPaginationParams(limit: fetchCount, id: id);

      if (fetchMore) {
        final pState = state as Pagination<ReviewModel>;

        state = PaginationFetchingMore<ReviewModel>(
            content: [...pState.content],
            hasMore: pState.hasMore,
            totalElements: pState.totalElements,
            totalPages: pState.totalPages);

        paginationParams = paginationParams.copyWith(
          limit: fetchCount,
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

      final res = await repository.reviewPaginate(
          id: id, paginationParams: paginationParams);
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
      state = PaginationError(message: '데이터를 가지고오지 못했습니다.');
    }
  }
}
