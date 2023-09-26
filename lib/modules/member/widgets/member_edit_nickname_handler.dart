import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';
import 'package:sip_app/modules/member/providers/member_edit_nicnkname_provider.dart';

class MemberEditNicknameHandler extends ConsumerWidget {

  MemberEditNicknameHandler();

  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(memberEditNicknameProvider);

    final isLoading = data is ServerStatusLoading;
    final isError = data is ServerStatusError;
    final isSuccess = data is ServerStatusSuccess;

    if (isSuccess) {
      context.pop();
    }

    return LoadingOverlay(isLoading: isLoading, child: SizedBox.shrink());
  }
}