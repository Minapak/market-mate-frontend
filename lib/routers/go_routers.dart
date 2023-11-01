import 'package:go_router/go_router.dart';
import 'package:sip_app/constants/path.dart';
import 'package:sip_app/main.dart';
import 'package:sip_app/modules/auth/screens/forgot_password1_screen.dart';
import 'package:sip_app/modules/auth/screens/signin_screen.dart';
import 'package:sip_app/modules/auth/screens/signup_email_screen.dart';
import 'package:sip_app/modules/auth/screens/signup_name_screen.dart';
import 'package:sip_app/modules/auth/screens/signup_password_screen.dart';
import 'package:sip_app/modules/auth/screens/signup_phone_screen.dart';
import 'package:sip_app/modules/auth/screens/on_boarding_screen.dart';
import 'package:sip_app/modules/auth/screens/splash_screen.dart';
import 'package:sip_app/modules/community/screens/communities_screen.dart';
import 'package:sip_app/modules/expert/screens/expert_detail_screen.dart';
import 'package:sip_app/modules/expert/screens/experts_screen.dart';
import 'package:sip_app/modules/faq/screens/faq_screen.dart';
import 'package:sip_app/modules/main/screens/home_screen.dart';
import 'package:sip_app/modules/market/screens/market_detail_screen.dart';
import 'package:sip_app/modules/market/screens/markets_screen.dart';
import 'package:sip_app/modules/community/screens/community_list_manage_screen.dart';
import 'package:sip_app/modules/matching/screens/expert_matching_detail_screen.dart';
import 'package:sip_app/modules/matching/screens/expert_matchings_screen.dart';
import 'package:sip_app/modules/matching/screens/matchings_screen.dart';
import 'package:sip_app/modules/member/screens/member_edit_nickname_screen.dart';
import 'package:sip_app/modules/member/screens/member_edit_password_screen.dart';
import 'package:sip_app/modules/my_page/screens/mypage_screen.dart';
import 'package:sip_app/modules/my_page/screens/mypage_notifications_screen.dart';
import 'package:sip_app/modules/my_page/screens/mypage_profile_screen.dart';
import 'package:sip_app/modules/category/screens/expert_categories_screen.dart';
import 'package:sip_app/modules/category/screens/expert_sub_categories_screen.dart';
import 'package:sip_app/modules/expert/screens/mypage_register_expert_screen.dart';
import 'package:sip_app/modules/qna/screens/qna_screen.dart';
import 'package:sip_app/modules/review/screens/mypage_reviews_screen.dart';
import 'package:sip_app/modules/service_center/screens/service_center_screen.dart';
import 'package:sip_app/modules/wholesaler/screens/wholesales_market_screen.dart';
import 'package:sip_app/modules/wishlist/screens/mypage_wishlist_screen.dart';

import 'package:sip_app/modules/wholesaler/screens/wholesales_screen.dart';

import '../modules/expert/screens/experts_market_screen.dart';
import '../modules/expert/widgets/expert_search_page.dart';
import '../modules/market/widgets/market_search_page.dart';
import '../modules/my_page/screens/mypage_profile_screen.dart';
import '../modules/wholesaler/screens/wholesales_detail_screen.dart';
import '../modules/wholesaler/widgets/wholesaler_search_page.dart';
//Flutter 애플리케이션 내에서 화면 전환 및 라우팅을 관리하기 위한 라우팅 설정
final GoRouter goRouter = GoRouter(
  //initialLocation: PATH_SPLASH,// 앱 시작 시 초기 경로
 initialLocation: PATH_HOME,
 //initialLocation: PATH_IMAGE_UPLOAD,
  routes: [
    GoRoute(
        path: '/signup', // '/signup' 경로에 대한 설정
        pageBuilder: (_, state) => NoTransitionPage(child: SignupNameScreen()),
        routes: [
          GoRoute(
            path: 'email', //'/signup/email' 경로 설정
            pageBuilder: (_, state) => NoTransitionPage(child: SignupEmailScreen()),
          ),
          GoRoute(
            path: 'phone', // '/signup/phone' 경로 설정
            pageBuilder: (_, state) => NoTransitionPage(child: SignupPhoneScreen()),
          ),
          GoRoute(
            path: 'password', // '/signup/password' 경로 설정
            pageBuilder: (_, state) => NoTransitionPage(child: SignupPasswordScreen()),
          ),
        ]
    ),
    // '/test' 경로 설정
    GoRoute(
        path: '/test',
        pageBuilder: (_, state) => NoTransitionPage(child: ExpertMatchingDetailScreen())),
    // PATH_SPLASH에 대한 경로 설정
    GoRoute(
        path: PATH_SPLASH,
        pageBuilder: (_, state) => NoTransitionPage(child: SplashScreen())),
    // PATH_SIGNIN에 대한 경로 설정
    GoRoute(
        path: PATH_IMAGE_UPLOAD,
        pageBuilder: (_, state) => NoTransitionPage(child: MultipleImageUploader())),
    // PATH_SIGNIN에 대한 경로 설정
    GoRoute(
        path: PATH_SIGNIN,
        pageBuilder: (_, state) => NoTransitionPage(child: SigninScreen())),
    GoRoute(
        path: PATH_FINDIDPW,
        pageBuilder: (_, state) => NoTransitionPage(child: ForgotPassword1Screen())),
    // PATH_HOME에 대한 경로 설정
    GoRoute(
        path: PATH_MARKETS,
        pageBuilder: (_, state) => NoTransitionPage(child: MarketsScreen())),
    GoRoute(
        path: PATH_MARKETS_SEARCH,
        pageBuilder: (_, state) => NoTransitionPage(child: MarketSearchPage())),
    GoRoute(
      // home 경로에 대한 설정:
      // pageBuilder 함수는 HomeScreen() 위젯을 생성하여 페이지로 사용합니다.
        path: PATH_HOME,
        pageBuilder: (_, state) => NoTransitionPage(child: HomeScreen()),
        routes: [
          //home/markets 경로에 대한 설정:
          // builder 함수는 MarketsScreen() 위젯을 생성하여 반환합니다.
          GoRoute(
              path: 'markets',
              builder: (context, state) {
                return MarketsScreen();
              },
              // '/home/markets/detail/:id' 경로 설정
              routes: [
                GoRoute(
                  // 경로는 동적인 파라미터 :id를 포함하며, 해당 파라미터는 경로 파라미터로 사용됩니다
                  ///home/markets/detail/:id 경로로 이동할 때 MarketDetailScreen()을 렌더링하며,
                  /// 경로 파라미터와 쿼리 파라미터를 활용하여 화면을 초기화합니다.
                  /// 이를 통해 앱 내에서 다양한 경로와 화면 간의 전환 및 데이터 전달이 가능해집니다.
                    path: 'detail/:id',
                    name: 'marketDetail',
                    // builder 함수는 MarketDetailScreen() 위젯을 생성하고,
                    // 경로 파라미터 id와 쿼리 파라미터 marketName을 이용하여 위젯을 초기화합니다
                    builder: (context, state) {
                      return MarketDetailScreen(
                        marketId: state.pathParameters['id'] ?? '0',
                        marketName: state.queryParameters['marketName'] ?? '',
                      );
                    }),
              ]),

        ]),
    GoRoute(
        path: PATH_EXPERTS_SEARCH,
        pageBuilder: (_, state) => NoTransitionPage(child: ExpertSearchPage())),
    GoRoute(
        path: PATH_EXPERTS,
        pageBuilder: (_, state) => NoTransitionPage(child: ExpertsScreen(
          mainCategoryId: state.queryParameters['mainCategoryId'] ?? '',
        )),
        routes: [

          // GoRoute(
          //     path: 'experts/:id/matchings',
          //     name: 'expertMatchings',
          //     builder: (context, state) {
          //       return ExpertDetailScreen(
          //         id: state.pathParameters['id'] ?? '0',
          //       );
          //     }),
        ]),
    GoRoute(
        path: '/experts/detail/:id',
        name: 'expertDetail',
        builder: (context, state) {
          return ExpertDetailScreen(
            expertId: state.pathParameters['id'] ?? '0',
            expertName: state.queryParameters['name'] ?? '',
          );
        }),
    GoRoute(
        path: '/markets/:id/experts',
        name: 'marketExpert',
        builder: (context, state) {
          return ExpertsMarketScreen(
            marketId: state.pathParameters['id'] ?? '0',
          );
        }),
    GoRoute(
        path: PATH_WHOLESALER,
        pageBuilder: (_, state) => NoTransitionPage(child: wholesalesScreen())),
    GoRoute(
        path: PATH_WHOLESALER_SEARCH,
        pageBuilder: (_, state) => NoTransitionPage(child: WholesalerSearchPage())),
    GoRoute(
        path: '/wholesale/:id',
        name: 'wholesalesDetail',
        builder: (context, state) {
          return wholesalesDetailScreen(
            wholesalerId: state.pathParameters['id'] ?? '0',
            wholesalerName: state.queryParameters['name'] ?? '',
          );
        }),
    GoRoute(
        path: '/markets/:id/wholesale',
        name: 'marketWholesale',
        builder: (context, state) {
          return WholesalesMarketScreen(
            marketId: state.pathParameters['id'] ?? '0',
          );
        }),
    GoRoute(
        path: PATH_MYPAGE,
        pageBuilder: (_, state) => NoTransitionPage(child: MypageScreen()),
        routes: [
          GoRoute(
              path: 'reviews',
              builder: (context, state) {
                return MypageReviewsScreen();
              }),
          GoRoute(
              path: 'matchings',
              builder: (context, state) {
                return MypageMatchingsScreen();
              }),
          GoRoute(
              path: 'services',
              builder: (context, state) {
                return ServiceCenterScreen();
              },
              routes: [
                GoRoute(
                    path: 'faqs',
                    builder: (context, state) {
                      return FaqScreen();
                    }),
                GoRoute(
                    path: 'qnas',
                    builder: (context, state) {
                      return QnaScreen();
                    }),
              ]
          ),
          GoRoute(
              path: 'expert',
              builder: (context, state) {
                return MypageRegisterExpertScreen();
              },
              //ExpertCategoriesScreen
              routes: [
                GoRoute(
                    path: 'categories',
                    builder: (context, state) {
                      return ExpertCategoriesScreen();
                    },
                    //ExpertCategoriesScreen
                    routes: [
                      GoRoute(
                          path: 'sub',
                          builder: (context, state) {
                            return ExpertSubCategoriesScreen();
                          }),
                    ]),
              ]),
          GoRoute(
              path: 'profile',
              builder: (context, state) {
                return MypageProfileScreen();
              },
              routes: [
                GoRoute(
                    path: 'nickname',
                    name: 'editNickname',
                    builder: (context, state) {
                      return MemberEditNicknameScreen(
                        currentNickname: state.queryParameters['nickname'] ?? '',
                      );
                    }),
                GoRoute(
                    path: 'password',
                    name: 'editPassword',
                    builder: (context, state) {
                      return MemberEditPasswordScreen();
                    }),
              ]
          ),
          // GoRoute(
          //     path: 'communities',
          //     builder: (context, state) {
          //       return CommunitylistManageScreen();
          //     }),
          GoRoute(
              path: 'notifications',
              builder: (context, state) {
                return MypageNotificationsScreen();
              }),
          GoRoute(
              path: 'wishlist',
              builder: (context, state) {
                return MypageWishlistScreen();
              }),
        ]),
  ],
);