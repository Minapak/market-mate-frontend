import 'package:flutter/material.dart';
import 'package:sip_app/constants/colors.dart';

class MarketContent extends StatelessWidget {
  final String content;

  MarketContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          content,
          style: TextStyle(
              color: SECTION_FONT_COLOR,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ));
  }
}