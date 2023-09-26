import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';

import '../../../constants/path.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? actionWidget;

  const HomeAppBar({required this.title, this.actionWidget, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(54.0);

  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      backgroundColor: Colors.white,
      title: Text(title,
          style: TextStyle(
            color: SECTION_FONT_COLOR,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset('assets/icons/icon_back.svg'),
        onPressed: () {
          context.go(PATH_SIGNIN);
        },
      ),
      actions: [
        actionWidget ?? SizedBox.shrink(),
      ],
    );
  }
}
