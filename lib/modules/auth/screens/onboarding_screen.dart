import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sip_app/modules/auth/widgets/signin_view.dart';
import 'package:sip_app/modules/auth/models/onboarding_model.dart';
import 'package:sip_app/config/colors.dart';
import 'package:sip_app/utils/common_button.dart';
import 'package:sip_app/config/font_family.dart';
import 'package:sip_app/config/size_config.dart';
import 'package:sip_app/config/string_config.dart';

class OnBoardingController extends ChangeNotifier {
  int pageViewIndex = 0;

  void setPageViewIndex(int index) {
    pageViewIndex = index;
    notifyListeners();
  }
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingController onBoardingController = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          right: SizeFile.height8.w,
          top: MediaQuery.of(context).size.height / 35,
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => SigninView()),
            );
          },
          child: Text(
            (onBoardingController.pageViewIndex == 0 ||
                onBoardingController.pageViewIndex == 1)
                ? StringConfig.skip
                : "",
            style: const TextStyle(
              fontFamily: lexendMedium,
              color: ColorFile.appColor,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: ColorFile.appColor,
              fontSize: SizeFile.height16,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeFile.height20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onBoardingList.length,
                controller: _pageController,
                allowImplicitScrolling: true,
                onPageChanged: (value) {
                  onBoardingController.setPageViewIndex(value);
                },
                itemBuilder: (context, index) {
                  index = onBoardingController.pageViewIndex;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        onBoardingList[index].image ?? "",
                        height: SizeFile.height / 1.5,
                        width: SizeFile.width,
                      ),
                      Text(
                        onBoardingList[index].title ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: lexendMedium,
                          fontSize: SizeFile.height24,
                          fontWeight: FontWeight.w500,
                          color: ColorFile.appbarTitleColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onBoardingList.length,
                    (int index) => buildDot(index: index),
              ),
            ),
            SizedBox(height: SizeFile.height20.h),
            GestureDetector(
              onTap: () {
                if (onBoardingController.pageViewIndex == onBoardingList.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => SigninView()),
                  );
                }
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              child: ButtonCommon(
                text: (onBoardingController.pageViewIndex == onBoardingList.length - 1)
                    ? StringConfig.getStarted
                    : StringConfig.next,
                textColor: ColorFile.whiteColor,
              ),
            ),
            SizedBox(height: SizeFile.height40.h),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: SizeFile.height4.w),
      height: (onBoardingController.pageViewIndex == index) ? SizeFile.height8.h : SizeFile.height10.h,
      width: (onBoardingController.pageViewIndex == index) ? SizeFile.height20.h : SizeFile.height10.h,
      decoration: BoxDecoration(
        color: (onBoardingController.pageViewIndex == index) ? ColorFile.appColor : ColorFile.onBoardingNext,
        borderRadius: BorderRadius.circular(SizeFile.height11.w),
      ),
    );
  }
}