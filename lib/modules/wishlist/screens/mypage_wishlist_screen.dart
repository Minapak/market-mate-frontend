import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/wishlist/widgets/mypage_wishlist_view.dart';

class MypageWishlistScreen extends StatelessWidget {
  const MypageWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      appBar: BackAppBar(title: '찜한 전문가 리스트'),
      child: MypageWishlistView(),
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
    );
  }
}
