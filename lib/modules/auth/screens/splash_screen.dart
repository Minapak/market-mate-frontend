import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sip_app/modules/auth/widgets/signin_view.dart';
import 'package:sip_app/modules/auth/models/onboarding_model.dart';
import 'package:sip_app/config/colors.dart';
import 'package:sip_app/utils/common_button.dart';
import 'package:sip_app/config/font_family.dart';
import 'package:sip_app/config/size_config.dart';
import 'package:sip_app/config/string_config.dart';
import 'package:sip_app/modules/auth/controller/on_boarding_controller.dart';
import 'package:sip_app/modules/auth/providers/auth_provider.dart';
import 'package:sip_app/utils/asset_image_paths.dart';
import 'dart:async';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {


  @override
  void initState() {
    super.initState();
    // authProvider.notifier.checkTokenSplash(context)가 완료될 때까지 대기
    // Future.delayed(Duration.zero, () async {
    //   await ref.read(authProvider.notifier).checkTokenSplash(context);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetImagePaths.splashScreenImage);
  }
}

