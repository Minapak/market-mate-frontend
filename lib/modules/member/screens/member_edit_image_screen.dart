import 'package:flutter/material.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/modules/common/widgets/back_appbar.dart';
import 'package:sip_app/modules/common/widgets/loading_overlay.dart';
import 'package:sip_app/modules/member/widgets/member_edit_image_view.dart';
import 'package:sip_app/modules/member/widgets/member_edit_image_handler.dart';
import 'package:sip_app/modules/my_page/widgets/mypage_profile_view.dart';

class MemberEditImageScreen extends StatelessWidget {
  final String currentImage;

  MemberEditImageScreen({required this.currentImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
       children: [
         // DefaultLayout(
         //   appBar: BackAppBar(
         //     title: '이름 수정',
         //   ),
         //   child: MemberImageView(this.currentImage),
         //   backgroundColor: Colors.white,
         // ),
         MemberEditImageHandler(),
       ],
    );
  }
}
