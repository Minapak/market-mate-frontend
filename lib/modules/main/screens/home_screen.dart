
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/common/screens/default_layout.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/modules/common/widgets/main_appbar.dart';
import 'package:sip_app/modules/common/widgets/easy_search_bar.dart';
import 'package:sip_app/modules/common/widgets/main_bottom_navigationbar.dart';
import 'package:sip_app/modules/expert/providers/experts_provider.dart';
import 'package:sip_app/modules/main/providers/main_provider.dart';
import 'package:sip_app/modules/main/widgets/banners_view.dart';
import 'package:sip_app/modules/main/widgets/categories_view.dart';
import 'package:sip_app/modules/main/widgets/member_view.dart';
import 'package:sip_app/modules/main/widgets/market_intro_view.dart';
import 'package:sip_app/modules/main/widgets/power_experts_view.dart';
import 'package:sip_app/modules/main/widgets/section_view.dart';
import 'package:sip_app/modules/auth/providers/signin_provider.dart';
import 'package:sip_app/modules/my_page/screens/mypage_profile_screen.dart';

import '../../auth/providers/auth_provider.dart';
import '../../my_page/widgets/mypage_profile_view.dart';
import '../../my_page/widgets/mypage_view.dart';
// ConsumerWidget을 확장하여 상태를 소비하고 UI를 빌드하는 역할
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});


  //build 메서드는 위젯의 UI를 구성하는 역할
  // context와 ref를 인자로 받아 사용
  // context는 빌드 컨텍스트를 나타내며,
  // ref는 Riverpod 상태 및 프로바이더를 사용하기 위한 레퍼런스입니다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String searchValue = '';
    final List<String> _suggestions = ['Afeganistan', 'Albania', 'Algeria', 'Australia', 'Brazil', 'German', 'Madagascar', 'Mozambique', 'Portugal', 'Zambia'];

    final isLoggedIn = ref.watch(checkLoggedInProvider);
    // mainFutureProvider 프로바이더의 값을 감시
    // 이 프로바이더를 통해 앱의 메인 데이터를 비동기로 가져옴
    final config = ref.watch(mainFutureProvider);
    // mainFutureProvider의 상태에 따라 다른 위젯을 반환
    return config.when(
      // 데이터가 로드되었을 때는 데이터를 활용한 위젯을 반환
        data: (data) {
          return DefaultLayout(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  BannersView(banners: data.banners),
                  SizedBox(height: 40),
                  SectionView(
                    child: CategoriesView(categories: data.mainCategories),
                    label: '창업분야 선택',
                  ),
                  SizedBox(height: 40),
                  SectionView(
                    child: PowerExpertsView(
                      experts: data.powerExperts,
                    ),
                    isNeedRoute: true,
                    routePath: isLoggedIn ? PATH_EXPERTS : PATH_SIGNIN,
                    label: '파워 전문가',

                  ),
                  SizedBox(height: 40),
                  SectionView(
                    child: MarketIntroView(
                      markets: data.markets,
                    ),
                    isNeedRoute: true,
                    routePath: isLoggedIn ? PATH_MARKETS : PATH_SIGNIN,
                    label: '시장 소개',
                  ),
                  SizedBox(height: 40),
                  // SectionView(
                  //   // child: MemberView(
                  //   //     members: data.members,
                  //   //   ),
                  //
                  //   isNeedRoute: true,
                  //   routePath: isLoggedIn ? PATH_USER_PROFILE : PATH_SIGNIN,
                  //   label: '마이페이지',
                  // ),
                ],
              ),
            ),
            appBar: MainAppBar(
              // appBar: EasySearchBar(
              //     title: const Text(''),
              //   onSearch: (value) { // onSearch 콜백 제공
              //     // 여기에서 검색 결과 또는 다른 작업을 수행할 수 있습니다.
              //     // 예를 들어, 검색 결과를 상태로 업데이트하려면 다음과 같이 작성할 수 있습니다.
              //     ref.read(expertListProvider
              //     as ProviderListenable).state = value; // 검색 결과를 상태로 업데이트
              //
              //     // 여기에서 검색 결과 또는 다른 작업을 수행할 수 있습니다.
              //   },
              //   suggestions: _suggestions,
              // ),
            ),
            appbarColor: PRIMARY_BACKGROUND_COLOR,
            backgroundColor: PRIMARY_BACKGROUND_COLOR,
            bottomNavigationBar: MainBottomNavigationBar(bottomTabIndex: 0),
            isNeedAppbar: true,

          );

        },
        // 에러가 발생하면 'Error' 텍스트를 반환
        error: (err, stack) => Text('Error'),
        // 로딩 중일 때는 로딩 인디케이터를 반환
        loading: () => const CircularProgressIndicator());
  }


}