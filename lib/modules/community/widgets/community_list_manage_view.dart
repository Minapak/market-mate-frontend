import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/community/providers/my_comment_list_provider.dart';
import 'package:sip_app/modules/community/providers/my_community_list_provider.dart';
import 'package:sip_app/modules/community/providers/my_communities_comments_view_provider.dart';

class CommunityListManageView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ManageCommunityType selectedType =
        ref.watch(myCommunitiesCommentsViewProvider);

    // 내 글 , 댓글 탭 변경
    void onChangeSelectType(ManageCommunityType type) {
      ref.read(myCommunitiesCommentsViewProvider.notifier).state = type;
    }

    return Column(
      children: [
        Row(
          children: [
            MypageCommunitiesTab(
              isSelected: selectedType == ManageCommunityType.COMMUNITIES_TYPE,
              label: '작성 글',
              selectType: ManageCommunityType.COMMUNITIES_TYPE,
              onChangeSelectType: onChangeSelectType,
            ),
            MypageCommunitiesTab(
                isSelected: selectedType == ManageCommunityType.COMMENTS_TYPE,
                label: '작성 댓글',
                selectType: ManageCommunityType.COMMENTS_TYPE,
                onChangeSelectType: onChangeSelectType),
          ],
        ),
        Expanded(
          child: selectedType == ManageCommunityType.COMMENTS_TYPE
              ? MypageCommunityCommentWrapper()
              : MypageCommunityContentWrapper(),
        )
      ],
    );
  }
}

class MypageCommunitiesTab extends StatelessWidget {
  final bool isSelected;
  final String label;
  final ManageCommunityType selectType;
  final Function onChangeSelectType;

  const MypageCommunitiesTab(
      {required this.isSelected,
      required this.label,
      required this.selectType,
      required this.onChangeSelectType,
      Key? key})
      : super();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () {
            onChangeSelectType(selectType);
          },
          child: Container(
              padding: EdgeInsets.only(top: 10),
              color: Colors.white,
              width: double.infinity,
              child: Column(children: [
                Text(label,
                    style: TextStyle(
                        color: isSelected
                            ? BUTTON_PRIMARY_COLOR
                            : BOTTOM_NAVI_TEXT_COLOR,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
                Container(
                    height: 2,
                    margin: EdgeInsets.only(top: 10),
                    color: isSelected
                        ? NAVIGATION_TEXT_COLOR
                        : BUTTON_GRAY_BORDER_COLOR)
              ])),
        ));
  }
}

class MypageCommunityContentWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myCommunityListProvider);

    if (data is PaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is PaginationError) {
      return Center(child: Text('에러'));
    }

    final pData = data as Pagination;

    return ListView.builder(
      itemCount: pData.content.length,
      itemBuilder: (context, index) {
        return MypageCommunityItem();
      },
    );
  }
}

class MypageCommunityCommentWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(myCommentListProvider);

    if (data is PaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is PaginationError) {
      return Center(child: Text('에러'));
    }

    final pData = data as Pagination;

    return ListView.builder(
      itemCount: pData.content.length,
      itemBuilder: (context, index) {
        return MypageCommunityItem();
      },
    );
  }
}

class MypageCommunityItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('글 제목글제목ㅁ니아ㅓㅁ니아ㅓ미나어 ',
            style: TextStyle(
                color: FIXED_WIDGET_BACKGROUNG_COLOR,
                fontSize: 16,
                fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        Text('내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: COMMUNITY_CATEGORY_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        SizedBox(height: 16),
        Text('2023.03.27',
            style: TextStyle(
                color: BOTTOM_NAVI_TEXT_COLOR,
                fontSize: 14,
                fontWeight: FontWeight.w400))
      ]),
    );
  }
}
