import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/market/models/market_model.dart';
import 'package:sip_app/modules/market/repositories/market_repository.dart';

final marketDetailNotifierProvider = StateNotifierProvider.family
  <MarketDetailStateNotifier, ServerStatusBase, int>((ref, marketId) {
    final Dio dio = Dio();
    final MarketRepository repository = MarketRepository(dio, baseUrl: "$SERVER_BASE_URL/users/markets");

    final notifier = MarketDetailStateNotifier(repository: repository, marketId: marketId);

    return notifier;
});

class MarketDetailStateNotifier extends StateNotifier<ServerStatusBase> {
  final int marketId;
  final MarketRepository repository;

  MarketDetailStateNotifier({
    required this.marketId, required this.repository
  }) : super(ServerStatusLoading()){
    getMarketDetail();
  }

  Future<void> getMarketDetail() async {
    try {
      print('marketId:$marketId');
      final res = await repository.getMarket(id: marketId);
      print('res:$res');
      if (!res.success) {
        state = ServerStatusError(message: '서버 에러');
      }

      final MarketModel data = res.response;

      state = ServerStatusDataSuccess(data: data);

    } catch(error) {
      print('error: $error');
      state = ServerStatusError(message: '서버 에러');
    }
  }


}
//
// final marketFutureProvider = FutureProvider<MarketModel>((ref) async {
//   try {
//     final Dio dio = Dio();
//     final MarketRepository repository = MarketRepository(dio, baseUrl: 'http://172.30.1.64/api/v1/users/markets');
//     // final res = await repository.getMarket();
//
//   } catch(error) {
//     print(error);
//     throw Exception("Failed to fetch Market");
//   }
// });
// //