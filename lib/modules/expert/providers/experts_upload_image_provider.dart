import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/models/server_status_model.dart';
import 'package:sip_app/modules/expert/repositories/expert_repository.dart';
import 'package:sip_app/modules/member/providers/member_provider.dart';
import 'package:sip_app/modules/wishlist/models/response_check_wish_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final ExpertUploadImageProvider = StateNotifierProvider.family
<ExpertUploadImageStateNotifier, ServerStatusBase, int>((ref, expertId) {
  final Dio dio = Dio();

  final repository = ExpertRepository(dio, baseUrl: '$SERVER_BASE_URL/users');
  final userUUID = ref.watch(memberUUIDProvider);
  final notifier = ExpertUploadImageStateNotifier(repository: repository, userUUID: userUUID, expertId: expertId);
  return notifier;
});


class ExpertUploadImageStateNotifier extends StateNotifier<ServerStatusBase> {
  final ExpertRepository repository;
  final String userUUID;
  final int expertId;

  ExpertUploadImageStateNotifier({
    required this.userUUID,
    required this.repository,
    required this.expertId,
  })
      : super(ServerStatusInitial()){

  }

}



