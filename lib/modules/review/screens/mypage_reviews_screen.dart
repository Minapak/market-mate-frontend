import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/review/widgets/mypage_reviews_handler.dart';
import 'package:sip_app/modules/review/widgets/mypage_reviews_view.dart';

class MypageReviewsScreen extends StatelessWidget {
  const MypageReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultLayout(
          appBar: BackAppBar(title: '나의 리뷰'),
          child: MypageReviewsView(),
          backgroundColor: Colors.white,
        ),
        MypageReviewsHandler()
      ],
    );
  }
}
