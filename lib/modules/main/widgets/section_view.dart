import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';

class SectionView extends StatelessWidget {
  final Widget child;
  final String label;
  final bool isNeedRoute;
  final String? routePath;

  const SectionView(
      {required this.child,
      required this.label,
      this.isNeedRoute = false,
      this.routePath,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: SECTION_FONT_COLOR,
                ),
              ),
            ),
            isNeedRoute
                ? GestureDetector(
                    onTap: () {
                      context.push(routePath ?? PATH_HOME);
                    },
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('전체보기',
                              style: TextStyle(
                                  color: NAVIGATION_TEXT_COLOR,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          SizedBox(width: 6),
                          SizedBox(
                              width: 5,
                              height: 10,
                              child: SvgPicture.asset(
                                  'assets/icons/icon_arrow_right_blue.svg')),
                          SizedBox(width: 20),
                        ]),
                  )
                : SizedBox.shrink()
          ],
        ),
        SizedBox(height: 20),
        child,
      ],
    );
  }
}
