
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/member/repositories/member_repository.dart';
import 'package:sip_app/modules/review/providers/reviews_provider.dart';

final deleteReviewNotifierProvider = StateNotifierProvider.autoDispose<DeleteReviewNotifier, ServerStatusBase>((ref) {
  final Dio dio = Dio();
  final currentLocale = Intl.getCurrentLocale();
  dio.options.headers['Accept-Language'] = currentLocale;
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers["Authorization"] =
  "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYW0xMjNAbmF2ZXIuY29tIiwiYXV0aCI6IlJPTEVfTk9STUFMX01FTUJFUiIsInVzZXJVVUlEIjoiMmM5NzgwODM4OWQyOTkzMDAxODlkM2UwMTNjZTAwMDYiLCJpZGVudHlLZXkiOiJzYW0xMjNAbmF2ZXIuY29tIiwiZXhwIjoxNjk0NDg0OTAzfQ.Gx_69JHOYPIKJNvz8geM7xb68CwGddtoLPnddJuGy8GsEOlw9zuEYAJgnn32K5wOmSalS2hbaux11EW3vNJV7w";

  final userUUID = ref.watch(memberUUIDProvider);

  final repository = MemberRepository(dio, baseUrl: '$SERVER_BASE_URL/users/');
  final notifier = DeleteReviewNotifier(ref: ref, repository: repository, userUUID: userUUID);
  return notifier;
});

class DeleteReviewNotifier extends StateNotifier<ServerStatusBase>{
  final ref;
  final String userUUID;
  final MemberRepository repository;

  DeleteReviewNotifier({required this.ref, required this.userUUID, required this.repository})
      : super(ServerStatusInitial());

  Future<void> deleteReview({required int reviewId}) async {
      state = ServerStatusLoading();

      try {
        final res = await repository.deleteReview(userId: userUUID,reviewId: reviewId);

        if (!res.success) {
          state = ServerStatusError(message: '서버에러');
          return;
        }

        ref.read(myReviewsProvider.notifier).deleteReview(reviewId);
        state = ServerStatusSuccess();
      } catch(error) {
        state = ServerStatusError(message: '서버 에러');
      }
  }
}