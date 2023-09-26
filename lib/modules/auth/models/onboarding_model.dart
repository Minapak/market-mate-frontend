

import 'package:sip_app/utils/asset_image_paths.dart';
import 'package:sip_app/config/string_config.dart';

class OnBoarding{
  String? title;
  String? image;
  OnBoarding({this.title, this.image});
}
List<OnBoarding> onBoardingList = [
  OnBoarding(title: StringConfig.thousandOfDoctorsExpertsToHelpYourHealth,image: AssetImagePaths.onBoardingImage1),
  OnBoarding(title: StringConfig.healthChecksConsultationsEasilyAnywhereAnytime,image:  AssetImagePaths.onBoardingImage2),
  OnBoarding(title:  StringConfig.letSStartLivingHealthyAndWellWithUsRightNow,image:  AssetImagePaths.onBoardingImage3),
];
List<OnBoarding> darkOnBoardingList = [
  OnBoarding(title: StringConfig.thousandOfDoctorsExpertsToHelpYourHealth,image: AssetImagePaths.darkOnBoardingImage1),
  OnBoarding(title: StringConfig.healthChecksConsultationsEasilyAnywhereAnytime,image:  AssetImagePaths.darkOnBoardingImage2),
  OnBoarding(title:  StringConfig.letSStartLivingHealthyAndWellWithUsRightNow,image:  AssetImagePaths.darkOnBoardingImage3),
];
