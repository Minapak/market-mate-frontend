import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';

List<String> pages = [
  PATH_HOME,
  PATH_EXPERTS,
  PATH_WHOLESALER,
  PATH_MARKETS,
  PATH_MYPAGE,
  PATH_EXPERTS_TEST,
   PATH_SIGNIN
];

class MainBottomNavigationBar extends StatefulWidget {
  final int bottomTabIndex;
  final Color? backgroundColor;

  const MainBottomNavigationBar(
      {required this.bottomTabIndex, this.backgroundColor});

  @override
  MainBottomNavigationBarState createState() => MainBottomNavigationBarState();
}

class MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  int bottomTabIndex = 0;

  @override
  void initState() {
    super.initState();
    bottomTabIndex = widget.bottomTabIndex;
  }

  void onTap(int index) {
    context.go(pages[index]);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/icon_home.svg',
              )),
          activeIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              'assets/icons/icon_home_selected.svg',
            ),
          ),
          label: '홈',
        ),
        BottomNavigationBarItem(
          activeIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              'assets/icons/icon_pro_selected.svg',
            ),
          ),
          icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/icon_pro.svg',
              )),
          label: '전문가 찾기',
        ),
        BottomNavigationBarItem(
          activeIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              'assets/icons/icon_shop_selected.svg',
            ),
          ),
          icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/icon_shop.svg',
              )),
          label: '도소매 보기',
        ),
        BottomNavigationBarItem(
          activeIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              'assets/icons/icon_community_selected.svg',
            ),
          ),
          icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/icon_community.svg',
              )),
          label: '시장 보기',
        ),
        BottomNavigationBarItem(
          activeIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              'assets/icons/icon_user_selected.svg',
            ),
          ),
          icon: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/icon_user.svg',
              )),
          label: '마이페이지',
        ),
      ],
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      currentIndex: bottomTabIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Color.fromARGB(255, 86, 29, 29),
      // selectedFontSize: 10,
      // unselectedFontSize: 10,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        color: BLACK_COLOR_FONT,
        fontSize: 10,
        height: 2,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        height: 2,
        fontSize: 10,
        color: Colors.grey,
      ),
    );
  }
}
