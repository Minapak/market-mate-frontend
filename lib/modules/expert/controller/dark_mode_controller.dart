import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeController extends ChangeNotifier {
  bool isLightTheme = false;
  final String themeKey = 'theme';

  DarkModeController() {
    getThemeStatus();
  }

  void saveThemeStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(themeKey, isLightTheme);
  }

  void getThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLightTheme = prefs.getBool(themeKey) ?? true;
    notifyListeners();
  }
}