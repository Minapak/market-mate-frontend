import 'package:sip_app/modules/auth/constant/image_path_constants.dart';
import 'package:sip_app/modules/auth/constant/on_boarding_info.dart';
import 'package:sip_app/modules/auth/screens/contacts_permission.dart';
import 'package:flutter/material.dart';

class OnBoardingController {
  final PageController pageController = PageController();
  int selectedPage = 0;

  bool get isLastPage => selectedPage == onboardPage.length - 1;

  void forwardAction(BuildContext context) {
    if (isLastPage) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ContactsPermission(),
        ),
      );
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  List<OnBoardingInfo> onboardPage = [
    OnBoardingInfo(
      title: 'Create New Contacts',
      imageAsset: ImagePath.onBoardingImage1,
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
    OnBoardingInfo(
      imageAsset: ImagePath.onBoardingImage2,
      title: 'Add to Favorite',
      description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
    ),
  ];
}