// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sip_app/config/colors.dart';
import 'package:sip_app/config/font_family.dart';
import 'package:sip_app/config/size_config.dart';
import 'package:sip_app/utils/dark_mode.dart';

class CommonTextField extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onchange;
  final bool obscuretext;
  final TextInputType? keyboardType;

   CommonTextField({
    Key? key,
    required this.hinttext,
    required this.controller,
    required this.validator,
    required this.onchange,
    required this.obscuretext,
    this.keyboardType,
  }) : super(key: key);

  DarkModeController darkModeController = Get.put(DarkModeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIsWeb ? 40 : SizeFile.width / 1.13,
      decoration:  BoxDecoration(
          color: darkModeController.isLightTheme.value ? Colors.transparent : ColorFile.rectangleColor,
        borderRadius: BorderRadius.circular(SizeFile.height10.r),
        boxShadow: [
          BoxShadow(
            color:
            darkModeController.isLightTheme.value
                ? ColorFile.verticalDividerColor
                : ColorFile.rectangleColor,
          blurRadius: darkModeController.isLightTheme.value
              ? 2 : 0,
          spreadRadius:darkModeController.isLightTheme.value
              ? 2 : 0,
          offset: const Offset(0,0)
        )]
      ),
      child: TextFormField(
        obscureText: obscuretext,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        style:
        TextStyle(color: darkModeController.isLightTheme.value ? Colors.black : Colors.white, fontFamily: lexendRegular),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: '',
          hintText: hinttext,
          hintStyle: TextStyle(
              color: darkModeController.isLightTheme.value
                  ? ColorFile.appbarTitleColor : ColorFile.whiteColor,
              fontFamily: lexendRegular,
              fontWeight: FontWeight.w400,
              fontSize: SizeFile.height14.sp
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          filled: true,
          isDense: true,
          fillColor: darkModeController.isLightTheme.value
              ? ColorFile.whiteColor : ColorFile.rectangleColor,
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeFile.height10.r)),
            borderSide: BorderSide.none,
            // borderSide: BorderSide(
            //     color: ColorFile.greyColor.withOpacity(0.7), width: 1),
          ),
          focusedErrorBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(SizeFile.height10.r)),
            borderSide: const BorderSide(color: ColorFile.redColor, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: ColorFile.blueColor, width: 1),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.red, width: 1),
          ),
        ),
        onChanged: onchange,
      ),
    );
  }
}