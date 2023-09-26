import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ManageCommunityType {
  COMMUNITIES_TYPE,
  COMMENTS_TYPE,
}

// 내 글 , 댓글 탭 변경
final myCommunitiesCommentsViewProvider =
    StateProvider<ManageCommunityType>((ref) {
  return ManageCommunityType.COMMUNITIES_TYPE;
});
