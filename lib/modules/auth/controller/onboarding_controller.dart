
import 'package:flutter/material.dart';

class OnBoardingController extends ChangeNotifier {
  int _pageViewIndex = 0;

  int get pageViewIndex => _pageViewIndex;

  set pageViewIndex(int index) {
    _pageViewIndex = index;
    notifyListeners(); // 상태 변경을 알립니다.
  }
}