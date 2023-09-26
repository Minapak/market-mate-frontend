import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/main/models/main_model.dart';
import 'package:sip_app/modules/main/repositories/main_repository.dart';

final mainFutureProvider = FutureProvider<MainModel>((ref) async {
  try {
    final Dio dio = Dio();
    final MainRepository repository = MainRepository(dio, baseUrl: SERVER_BASE_URL);
    final res = await repository.getMainData();

    return res.response;
  } catch (error) {
    print(error);
    throw Exception("error");
  }
});
