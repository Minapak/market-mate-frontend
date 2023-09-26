import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sip_app/constants/colors.dart';

class SignupProgressbar extends StatefulWidget {
  final int step;

  SignupProgressbar({required this.step});

  @override
  SignupProgressbarState createState() => SignupProgressbarState();
}

class SignupProgressbarState extends State<SignupProgressbar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double getInitialProgress() {
    return (widget.step - 1) / 5;
  }

  double getFinalProgress() {
    return widget.step / 5;
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = Tween<double>(begin: getInitialProgress(), end: getFinalProgress()).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(widget.step.toString(), style: TextStyle(color: BUTTON_PRIMARY_COLOR, fontSize: 14, fontWeight: FontWeight.w700),),
            Text('/', style: TextStyle(color: SECTION_FONT_COLOR, fontSize: 14, fontWeight: FontWeight.w700),),
            Text('5', style: TextStyle(color: SECTION_FONT_COLOR, fontSize: 14, fontWeight: FontWeight.w700),),
          ],
        ),
        SizedBox(height: 8),
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          lineHeight: 10.0,
          percent: _animation.value,
          backgroundColor: CATEGORY_BACKGROUND_COLOR,
          progressColor: BUTTON_PRIMARY_COLOR,
          barRadius: Radius.circular(100),
        ),
      ],
    );
  }
}