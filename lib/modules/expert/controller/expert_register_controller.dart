import 'package:flutter/material.dart';
import 'package:sip_app/modules/expert/models/expert_register_model.dart';
import 'package:sip_app/utils/assete_icon_paths.dart';
import 'package:sip_app/config/string_config.dart';

class ExpertRegisterController {
  int selectedTimeIndex = 0;
  int selectedPackageIndex = 0;
  String selectedTime = '30 minutes';

  void changeTime(String language) {
    selectedTime = language;
  }

  final List<String> timeList = [
    '10 minutes',
    '25 minutes',
    '20 minutes',
    '25 minutes',
    '30 minutes',
    '60 minutes',
  ];

  List<ExpertRegisterModel> selectedPackageList = [
    ExpertRegisterModel(
        id: 0,
        thumbnail: AssetIconPaths.messagingDarkIcon,
        introduceExpert: StringConfig.messagingPackage,
        introduceContent: StringConfig.chatMessagesWithDoctor,
    ),
    ExpertRegisterModel(
      id: 1,
      thumbnail: AssetIconPaths.messagingDarkIcon,
      introduceExpert: StringConfig.messagingPackage,
      introduceContent: StringConfig.chatMessagesWithDoctor,
    ),
    ExpertRegisterModel(
      id: 2,
      thumbnail: AssetIconPaths.messagingDarkIcon,
      introduceExpert: StringConfig.messagingPackage,
      introduceContent: StringConfig.chatMessagesWithDoctor,
    ),
  ];
}