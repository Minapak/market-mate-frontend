
import 'package:flutter/material.dart';
import 'package:sip_app/constants/app_constants.dart';
import 'package:sip_app/constants/colors.dart';

class SignupInput extends StatefulWidget {
  final Function(String) onChangeValue;
  final bool isObscure;
  final bool? readOnly;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;


  SignupInput({
    required this.isObscure,
    required this.onChangeValue,
    this.controller,
    this.initialValue,
    this.readOnly = false,
    this.hintText = '텍스트를 입력해주세요.',

  });

  SignupInputState createState() => SignupInputState();
}

class SignupInputState extends State<SignupInput> {
  SignupInputState();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: GRAY_INPUT_BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextField(
        autofocus: true,
        controller: widget.controller,
        obscureText: widget.isObscure,
        readOnly: widget.readOnly ?? false,
        maxLines: 1,
        minLines: 1,
        onChanged: widget.onChangeValue,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,

        ),
        style: TextStyle(
          color: widget.readOnly == true ? GRAY_COLOR_FONT : BLACK_COLOR_FONT,  // Add this line
        ),
      ),
    );
  }
}