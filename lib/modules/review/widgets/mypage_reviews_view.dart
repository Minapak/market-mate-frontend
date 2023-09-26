import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/models/pagination.dart';
import 'package:sip_app/modules/review/providers/reviews_provider.dart';
import 'package:sip_app/modules/review/widgets/mypage_review_item_view.dart';

class MypageReviewsView extends ConsumerStatefulWidget {
  MypageReviewsState createState() => MypageReviewsState();
}

class MypageReviewsState extends ConsumerState<MypageReviewsView> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(myReviewsProvider);

    if (data is PaginationLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (data is PaginationError) {
      return Center(
        child: Text('에러'),
      );
    }

    final pData = data as Pagination;
    final dataLength = pData.content.length;

    if (dataLength == 0) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
          children: <Widget>[
            SvgPicture.asset('assets/icons/icon_error_gray.svg'),
            SizedBox(height: 10),
            Text(
              '작성한 리뷰가 없습니다.',
              style: TextStyle(
                  color: GRAY_COLOR_FONT,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ) // SVG 파일 로드
            // 다른 위젯들...
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      itemCount: dataLength > 0 ? dataLength : 1,
      itemBuilder: (context, index) {
        return MypageReviewItemView(
            review: data.content[index],
            isLast: index == dataLength - 1
        );
      },
    );
  }
}
