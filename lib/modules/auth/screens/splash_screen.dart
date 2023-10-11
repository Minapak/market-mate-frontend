import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sip_app/modules/auth/constant/font_family_constants.dart';
import 'package:sip_app/modules/auth/constant/image_path_constants.dart';
import 'package:sip_app/modules/auth/screens/contacts_permission.dart';
import 'package:sip_app/modules/auth/screens/on_boarding_screen.dart';

import '../../../constants/path.dart';
import '../../main/screens/home_screen.dart';
import 'contacts_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getOnboardInfo();
  }

  getOnboardInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isViewed = prefs.getBool('onBoard');
    if (isViewed == false) {
      Future.delayed(
        const Duration(seconds: 2),
            () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
            () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OnBoardingScreen(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              right: 30,
              child: Image.asset(
                ImagePath.frame1,
                height: 180,
              ),
            ),
            Positioned(
              top: 180,
              left: -20,
              child: Image.asset(
                ImagePath.frame3,
                height: 127,
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.logo,
                    height: 120,
                  ),
                  const SizedBox(width: 18),
                  // const Text(
                  //   '시장에서 프로를 만나다',
                  //   style: TextStyle(
                  //     fontFamily: FontFamilyData.latoBoldFont,
                  //     fontSize: 25,
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              bottom: 180,
              right: -10,
              child: Image.asset(
                ImagePath.frame4,
                height: 127,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                ImagePath.frame2,
                height: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}