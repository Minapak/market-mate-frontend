import 'package:sip_app/helpers/theme/app_theme.dart';
import 'package:sip_app/helpers/theme/theme_type.dart';
import 'package:flutter/material.dart';

class NavigationTheme {
  Color? backgroundColor,
      selectedItemIconColor,
      selectedItemTextColor,
      selectedItemColor,
      selectedOverlayColor,
      unselectedItemIconColor,
      unselectedItemTextColor,
      unselectedItemColor;

  static NavigationTheme getNavigationTheme([ThemeType? themeType]) {
    NavigationTheme navigationBarTheme = NavigationTheme();

      navigationBarTheme.backgroundColor = Colors.white;
      navigationBarTheme.selectedItemColor = Color(0xff3d63ff);
      navigationBarTheme.unselectedItemColor = Color(0xff495057);
      navigationBarTheme.selectedOverlayColor = Color(0x383d63ff);


    return navigationBarTheme;
  }
}
