import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/service_category/models/service_categories_pagination_params.dart';
import 'package:sip_app/modules/service_category/models/service_category_model.dart';
import 'package:sip_app/modules/service_category/repositories/service_category_repository.dart';

final ServiceCategoryListNotifierProvider = StateNotifierProvider.family
  <ServiceCategoryListNotifier, PaginationBase, String>((ref, serviceType) {
    final Dio dio = Dio();
   
    final ServiceCategoryRepository repository = ServiceCategoryRepository(
        dio, baseUrl: "$SERVER_BASE_URL/users/"
    );
    final notifier = ServiceCategoryListNotifier(
        repository: repository, serviceType:  serviceType
    );

    return notifier;
});

class ServiceCategoryListNotifier extends StateNotifier<PaginationBase> {
  final String serviceType;
  final ServiceCategoryRepository repository;

  ServiceCategoryListNotifier({required this.serviceType, required this.repository})
      : super(PaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 100,
    int page = 1,
    bool fetchMore = false, // 추가 데이터 요청
    bool forceRefetch = false, // 강제 리프레쉬
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

      ServiceCategoriesPaginationParams paginationParams = ServiceCategoriesPaginationParams(
        limit: fetchCount,
        page: page,
        serviceType: serviceType,
      );

      if (fetchMore) {
        final pState = state as Pagination<ServiceCategoryModel>;

        state = PaginationFetchingMore<ServiceCategoryModel>(
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
      state = PaginationError(message: '데이터를 불러오지 못했습니다');
    }
  }
}