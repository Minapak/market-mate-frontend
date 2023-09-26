import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';
import 'package:sip_app/modules/expert/models/expert_model.dart';
import 'package:sip_app/modules/matching/models/matching_model.dart';

String getMatchingStatusToString(MatchingStatus matchingStatus) {
  switch (matchingStatus) {
    case MatchingStatus.MATCHING_STANDBY:
      return '매칭대기';
    case MatchingStatus.MATCHING_ACCEPT:
      return '매칭수락';
    case MatchingStatus.MANAGER_CONNECT:
      return '매니저연결';
    case MatchingStatus.MATCHING_COMPLETE:
      return '매칭완료';
    case MatchingStatus.MATCHING_CANCEL:
      return '매칭취소';
    default:
      return 'Unknown';
  }
}

Color getMatchingStatusBgColor(MatchingStatus matchingStatus) {
  switch (matchingStatus) {
    case MatchingStatus.MATCHING_STANDBY:
      return INPUT_BACKGROUND_GRAY_COLOR;
    case MatchingStatus.MATCHING_ACCEPT:
      return BUTTON_PRIMARY_COLOR;
    case MatchingStatus.MANAGER_CONNECT:
      return Colors.white;
    case MatchingStatus.MATCHING_COMPLETE:
      return PRIMARY_DARK_BUTTON_COLOR;
    case MatchingStatus.MATCHING_CANCEL:
      return Colors.red;
    default:
      return INPUT_BACKGROUND_GRAY_COLOR;
  }
}

Color getMatchingStatusFontColor(MatchingStatus matchingStatus) {
  switch (matchingStatus) {
    case MatchingStatus.MATCHING_STANDBY:
      return BOTTOM_NAVI_TEXT_COLOR;
    case MatchingStatus.MATCHING_ACCEPT:
      return Colors.white;
    case MatchingStatus.MANAGER_CONNECT:
      return PRIMARY_DARK_BUTTON_COLOR;
    case MatchingStatus.MATCHING_COMPLETE:
      return Colors.white;
    case MatchingStatus.MATCHING_CANCEL:
      return Colors.white;
    default:
      return INPUT_BACKGROUND_GRAY_COLOR;
  }
}

String getCareerToString(ExpertCareer career) {
  switch (career) {
    case ExpertCareer.UNTIL_FIVE_YEAR:
      return '1년 이상 ~ 5년 미만';
    case ExpertCareer.UNTIL_TEN_YEAR:
      return '5년 이상 ~ 10년 미만';
    case ExpertCareer.UNTIL_TWENTY_YEAR:
      return '10년 이상 ~ 20년 미만';
    case ExpertCareer.UNTIL_THIRTY_YEAR:
      return '20년 이상 ~ 30년 미만';
    case ExpertCareer.OVER_THIRTY_YEAR:
      return '30년 이상';
    default:
      return '';
  }
}
