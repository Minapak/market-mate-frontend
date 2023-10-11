import 'dart:math';

import 'package:go_router/go_router.dart';
import 'package:sip_app/modules/auth/constant/font_family_constants.dart';
import 'package:sip_app/modules/auth/controller/on_boarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/path.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnBoardingController controllerData = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: controllerData.pageController,
              onPageChanged: (int index) {
                setState(() {
                  controllerData.selectedPage = index;
                });
              },
              itemCount: controllerData.onboardPage.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: size.height / 9,
                    ),
                    SizedBox(
                      height: size.height / 2.5,
                      child: Image.asset(
                        controllerData.onboardPage[index].imageAsset!,
                      ),
                    ),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Text(
                      controllerData.onboardPage[index].title!,
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      child: Text(
                        textAlign: TextAlign.center,
                        controllerData.onboardPage[index].description!,
                        style: const TextStyle(
                          fontFamily: FontFamilyData.latoRegularFont,
                          color: Color(0xff788082),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Row(
                children: List.generate(
                  controllerData.onboardPage.length,
                      (index) {
                    return Container(
                      margin: EdgeInsets.only(left: index == 0 ? 30 : 8),
                      height: 6,
                      width: controllerData.selectedPage == index ? 20 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: controllerData.selectedPage == index
                            ? const Color(0xff00C6FF)
                            : const Color(0xffD0D7D9),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: Transform.rotate(
                angle: pi / 4,
                child: InkWell(
                  onTap: () {
                //    controllerData.forwardAction();
                    context.go(PATH_HOME);
                   // storeOnboardInfo();
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    alignment: Alignment.center,
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff00C6FF),
                    ),
                    child: Transform.rotate(
                      angle: pi / 0.57,
                      child: controllerData.selectedPage == 0
                          ? const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 21,
                      )
                          : const Text(
                        'Start',
                        style: TextStyle(
                          fontFamily: FontFamilyData.latoRegularFont,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void storeOnboardInfo() async {
    bool isViewed = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onBoard', isViewed);
  }
}