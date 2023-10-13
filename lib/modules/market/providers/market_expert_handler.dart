import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/market/repositories/market_repository.dart';

import '../../common/models/pagination.dart';
import '../../common/models/server_status_model.dart';
import '../../expert/models/expert_model.dart';
import '../../expert/models/experts_pagination_params.dart';



// final ShowMarketExpertProvider = StateNotifierProvider.autoDispose<ShowMarketExpertNotifier, ServerStatusBase>((ref) {
//   final currentLocale = Intl.getCurrentLocale();
//   final Dio dio = Dio();
//   final MarketRepository repository = MarketRepository(dio, baseUrl: "$SERVER_BASE_URL/users/markets");
//   dio.options.headers['Accept-Language'] = currentLocale;
//   dio.options.headers['content-Type'] = 'application/json';
//
//   final notifier = ShowMarketExpertNotifier(repository: repository);
//
//   return notifier;
// });

// class ShowMarketExpertNotifier extends StateNotifier<ServerStatusBase>{
//   final MarketRepository repository;
//
//   ShowMarketExpertNotifier({required this.repository}): super(ServerStatusInitial());
//
//   Future<void> onShow({required int marketId}) async {
//     state = ServerStatusLoading();
//     try {
//       // param 생성
//       final res = await repository.getMarketsExpert(id: marketId);
//
//       if (res.success) {
//         state = ServerStatusSuccess();
//       } else {
//         state = ServerStatusError(message: '에러');
//       }
//     } on DioException catch(error) {
//
//       if (error.response != null) {
//         final errorRes = ErrorResponseModel.fromJson(error.response!.data);
//         print(errorRes.status.toString());
//         final message = errorRes.message ?? '';
//         state = ServerStatusError(message: message);
//       } else {
//         state = ServerStatusError(message: '죄송합니다\n잠시후 다시 시도해주세요.');
//       }
//     }
//   }
// }

final ShowMarketExpertProvider = StateNotifierProvider.autoDispose<ShowMarketExpertNotifier, PaginationBase>((ref) {
  final Dio dio = Dio();
  final MarketRepository repository = MarketRepository(dio,
      baseUrl: '$SERVER_BASE_URL/users/markets');

  final notifier =
  ShowMarketExpertNotifier(repository: repository);

  return notifier;
});

class ShowMarketExpertNotifier extends StateNotifier<PaginationBase> {
  final MarketRepository repository;

  ShowMarketExpertNotifier({
    required this.repository,
  }) : super(PaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 5,
    int page = 1,
    bool fetchMore = false, // 추가 데이터 요청
    bool forceRefetch = false, // 강제로 처음부터 로딩
    int marketId = 1
  }) async {

    try {
      // param 생성
      ExpertsPaginationParams paginationParams = ExpertsPaginationParams(
        limit: fetchCount,
        page: page,
      );

        paginationParams = paginationParams.copyWith(
          limit: fetchCount,
          page: page,
        );

      final res = await repository.getMarketsExpertPagenate(paginationParams: paginationParams, id: marketId);


      final bool isLoading = state is PaginationLoading;
      final bool isReFetching = state is PaginationRefetching;
      final bool isFetchingMore = state is PaginationFetchingMore;

      print("isLoading:"+isLoading.toString());
      print("isReFetching:"+isReFetching.toString());
      print("isFetchingMore:"+isFetchingMore.toString());
      // 2번 반환 상황
      if (fetchMore && (isLoading || isReFetching || isFetchingMore)) {
        return;
      }
        state = res.response;
      print("여기 오니 7");
    } catch (error) {
      state = PaginationError(message: "데이터를 불러오지 못했습니다");
    }
  }
}
