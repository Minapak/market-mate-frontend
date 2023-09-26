import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/routers/go_routers.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sip_app/modules/auth/screens/splash_screen.dart';
//앱 실행
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'c5f620fd6e4288fae50a90fcace53fec');

  runApp(ProviderScope(child: MyApp()));
  //runApp이 최초로 불러온 위젯
  //MyApp은 위젯 트리에서 최상단에 위치하는 위젯이며 스크린 레이아웃을 최초로 빌드하는 역할


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      title: 'Ship',
      routerConfig: goRouter,
      theme: ThemeData(fontFamily: 'NotoSansKR'),
      debugShowCheckedModeBanner: false,

      supportedLocales: [
        const Locale('ko', 'KR'),
        const Locale('en', 'US'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (Locale? locale, Iterable<Locale>? supportedLocales) {
        if (locale == null || supportedLocales == null || supportedLocales.isEmpty) {
          debugPrint("*language locale is null or supported locales are empty!!!");
          return supportedLocales?.first;
        }

        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            debugPrint("*language ok $supportedLocale");
            Intl.defaultLocale = supportedLocale.toLanguageTag();
            return supportedLocale;
          }
        }

        debugPrint("*language to fallback ${supportedLocales.first}");
        return supportedLocales.first;
      },
// home: SplashScreen(), // SplashScreen을 앱의 초기 화면으로 설정합니다.
    );



  }
}

