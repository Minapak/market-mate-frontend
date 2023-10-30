import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
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
import 'package:image_picker/image_picker.dart';
import 'package:sip_app/modules/expert/widgets/expert_image_uploader_view.dart';
import 'package:sip_app/modules/auth/screens/splash_screen.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
     // home: const MultipleImageUploader(),
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
//home: SplashScreen(), // SplashScreen을 앱의 초기 화면으로 설정합니다.
    );



  }
}

class MultipleImageUploader extends StatefulWidget {
  const MultipleImageUploader({Key? key}) : super(key: key);

  @override
  State<MultipleImageUploader> createState() => _MultipleImageUploaderState();
}

class _MultipleImageUploaderState extends State<MultipleImageUploader> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter multiple image upload'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    // height: 100,
                      constraints: BoxConstraints(
                        maxHeight: screenHeight / 3,
                      ),
                      width: screenWidth,
                      decoration: const BoxDecoration(
                        // border: Border.all(color: Colors.blue)
                      ),
                      child: _buildImageList()
                  ),

                  IconButton.filledTonal(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final images = await picker.pickMultiImage();
                      print('Imagessssss : $images');
                      // lakukan looping sebanyak jumlah image - do a looping process as much image length
                      for (final img in images) {
                        // simpan ke variabel ImageUploader.images - save into ImageUploader.images variable
                        ImageUploader.images.add(XFile(img.path));
                      }

                      setState(() {

                      });
                    },

                    icon: const Icon(Icons.camera_alt),
                  ),
                  const Text('Select image'),

                  const SizedBox(height: 40,),
                  IconButton.filledTonal(
                    onPressed: () async {

                      // abaikan saja variabel dataForServer - ignore the dataForServer variable
                      final dataForServer = {
                        "token": 'seller1-token-12345678',
                        "sellerId": '1',
                        "productId": '1',
                        "productName": 'Product 1',
                        "description": 'Product 1 Description',
                        "stock": '3',
                        "price": '1000',
                      };

                      final uploadStatus = await ImageUploader.uploadImage(data: dataForServer);

                      final Map<String, dynamic> uploadStatusData = jsonDecode(uploadStatus);
                      print(uploadStatusData);
                    },

                    icon: const Icon(Icons.upload),
                  ),

                  const Text('Upload')
                ],
              ),
            ),
          )
      ),
    );
  }

  Widget _buildImageList() {
    return CustomScrollView(
      slivers: [
        SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: ImageUploader.images.length,
                  (context, index) {
                return Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(left: 5, bottom: 10, right: 5),
                  decoration: const BoxDecoration(
                    // border: Border.all(color: Colors.red)
                  ),
                  child: Image.file(
                    File(ImageUploader.images[index].path),
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4
            )
        )
      ],
    );
  }
}