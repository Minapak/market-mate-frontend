import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/error_response_model.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';
import 'package:sip_app/modules/market/repositories/market_repository.dart';



final ShowMarketExpertProvider = StateNotifierProvider.autoDispose<ShowMarketExpertNotifier, ServerStatusBase>((ref) {
  final currentLocale = Intl.getCurrentLocale();
  final Dio dio = Dio();
  final MarketRepository repository = MarketRepository(dio, baseUrl: "$SERVER_BASE_URL/users/markets");
  dio.options.headers['Accept-Language'] = currentLocale;
  dio.options.headers['content-Type'] = 'application/json';

  final notifier = ShowMarketExpertNotifier(repository: repository);

  return notifier;
});

class ShowMarketExpertNotifier extends StateNotifier<ServerStatusBase>{
  final MarketRepository repository;

  ShowMarketExpertNotifier({required this.repository}): super(ServerStatusInitial());

  Future<void> onShow({required int marketId}) async {
    state = ServerStatusLoading();
    try {
      // param 생성
      final res = await repository.getMarketsExpert(id: marketId);

      if (res.success) {
        state = ServerStatusSuccess();
      } else {
        state = ServerStatusError(message: '에러');
      }
    } on DioException catch(error) {

      if (error.response != null) {
        final errorRes = ErrorResponseModel.fromJson(error.response!.data);
        print(errorRes.status.toString());
        final message = errorRes.message ?? '';
        state = ServerStatusError(message: message);
      } else {
        state = ServerStatusError(message: '죄송합니다\n잠시후 다시 시도해주세요.');
      }
    }
  }
}