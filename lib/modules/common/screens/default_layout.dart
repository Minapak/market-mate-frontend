import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Color? appbarColor;
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool isNeedListview;
  final bool isNeedAppbar;
  final PreferredSizeWidget? appBar;

  const DefaultLayout({
    required this.child,
    this.appbarColor,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.isNeedAppbar = false,
    this.isNeedListview = true,
    this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appbarColor ?? Colors.white, // 배경색 설정
      child: SafeArea(
        top: true,
        bottom: false,
        child: Container(
            color: backgroundColor ?? Colors.white, // 이곳에도 배경색 설정
            child: Scaffold(
                resizeToAvoidBottomInset : false,
                backgroundColor: Colors.transparent, // Scaffold의 배경색을 투명으로 설정
                appBar: appBar ?? null,
                body: child,
                bottomNavigationBar: bottomNavigationBar ?? null)),
      ),
    );
  }
}
