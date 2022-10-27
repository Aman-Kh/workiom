import 'dart:ui';

import 'package:flutter/material.dart';


Color scaffoldBgColor = const Color(0xFFF4F4F4);
Color primaryColor = Colors.white;//const Color(0xFF43a2db);
Color greenColor = Colors.green;
Color greyColor = const Color(0xFF6e7072);
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color orangeColor = Colors.orange;
Color redColor = Colors.red;
Color lightGreyColor = greyColor.withOpacity(0.1);
Color lightPrimaryColor = primaryColor.withOpacity(0.1);
Color darkBlueColor = const Color(0xFF43a2db);
Color veryDarkBlueColor = const Color(0xFF3a79ff);
Color lightBlueColor = const Color(0xFF5266a2);
Color veryLightGreyColor = const Color(0xFFE5E4E2);

TextStyle blackSmallBoldTextStyle = TextStyle(
  color: blackColor,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
);

TextStyle primaryButtonBoldTextStyle = TextStyle(
  color: whiteColor,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
);

ButtonStyle primaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(greyColor),
  foregroundColor: MaterialStateProperty.all(whiteColor),
  shape: MaterialStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(25),
  )),
);


TextStyle blackSmallTextStyle = TextStyle(
  color: blackColor,
  fontSize: 15.0,
  height: 1.3,
);


final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
final upperCaseRegex = RegExp(r'[A-Z]');
final lowerCaseRegex = RegExp(r'[a-z]');
final digitsRegex = RegExp(r'[0-9]');
final nonAlphanumericRegex = RegExp(r'^[!@#$%^&*(),.?":{}|<>]');
