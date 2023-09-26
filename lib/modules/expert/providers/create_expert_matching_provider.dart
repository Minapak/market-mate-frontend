import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/error_response_model.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/matching/models/create_matching_model.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';
import 'package:sip_app/modules/matching/repositories/matching_repository.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';

final createExpertMatchingProvider = StateNotifierProvider.autoDispose<CreateExpertMatchingStateNotifier, ServerStatusBase>((ref) {
  final currentLocale = Intl.getCurrentLocale();
  final Dio dio = Dio();
  dio.options.headers['Accept-Language'] = currentLocale;
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
  "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYW0xMjNAbmF2ZXIuY29tIiwiYXV0aCI6IlJPTEVfTk9STUFMX01FTUJFUiIsInVzZXJVVUlEIjoiMmM5NzgwODM4OWQyOTkzMDAxODlkM2UwMTNjZTAwMDYiLCJpZGVudHlLZXkiOiJzYW0xMjNAbmF2ZXIuY29tIiwiZXhwIjoxNjk0NDg0OTAzfQ.Gx_69JHOYPIKJNvz8geM7xb68CwGddtoLPnddJuGy8GsEOlw9zuEYAJgnn32K5wOmSalS2hbaux11EW3vNJV7w";

  final userUUID = ref.watch(memberUUIDProvider);
  final MatchingRepository repository = MatchingRepository(dio, baseUrl: SERVER_BASE_URL);
  final notifier = CreateExpertMatchingStateNotifier(repository: repository, userUUID: userUUID);

  return notifier;
});

class CreateExpertMatchingStateNotifier extends StateNotifier<ServerStatusBase>{
  final String userUUID;
  final MatchingRepository repository;

  CreateExpertMatchingStateNotifier({required this.userUUID,required this.repository}): super(ServerStatusInitial());

  Future<void> onMatch({required int expertId}) async {
    state = ServerStatusLoading();
    try {
      final CreateMatchingModel data = CreateMatchingModel(
          userUUID: userUUID,
          expertId: expertId,
          matchingStatus: MatchingStatus.MATCHING_STANDBY,
          activate: true
      );

      final res = await repository.createMatching(data: data);

      if (res.success) {
        state = ServerStatusSuccess();
      } else {
        state = ServerStatusError(message: '에러');
      }
    } on DioException catch(error) {

      if (error.response != null) {
        final errorRes = ErrorResponseModel.fromJson(error.response!.data);

        final message = errorRes.message ?? '';
        state = ServerStatusError(message: message);
      } else {
        state = ServerStatusError(message: '죄송합니다\n잠시후 다시 시도해주세요.');
      }
    }
  }
}