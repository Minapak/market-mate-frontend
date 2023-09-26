import 'dart:async';

import 'package:get/get.dart';
import 'package:sip_app/modules/auth/screens/onboarding_screen.dart';


class SplashController extends GetxController{
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 5), () => Get.off(OnBoardingScreen()));
  }
}