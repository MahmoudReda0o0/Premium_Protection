import 'package:flutter/material.dart';

import '../main.dart';

double mediaHeight =
    MediaQuery.of(navigatorKey.currentState!.context).size.height;
double mediaWidth =
    MediaQuery.of(navigatorKey.currentState!.context).size.width;

class Constant {

  static const Color grayDark = Color(0xFF353432),
      grayWhite = Color(0xFF90A09D),
      white = Color(0xFFEEEEEE),
      buttonColor = Color(0xFF196774),
      orangeDark = Color(0xFFEF6024),
      orangeWhite = Color(0xFFF1931F),
      red =Color(0xFFE43548),
      green = Color(0xFF2DB83D);

  // static const Color primaryColor =
  //         Color(0xFF1A73E8), // Blue gradient color from logo
  //     blueGradientLight = Color(0xFF4A90E2), // Lighter Blue from gradient
  //     softBlue = Color(0xFF007BFF),
  //     brightGreent = Color(0xFF28A745), //Bright green
  //     secondaryColor = Color(0xFFE64A19), // Orange gradient color from logo
  //     accentTextColor = Color(0xFF311010), // Dark Maroon text color from logo
  //     backgroundColor = Color(0xFFF8F9FA), // Light Gray
  //     cardColor = Color(0xFFEDE7F6), //Light Purple
  //     scaffoldBackgroundColor = Color(0xFFFBFBFB), // Neutral background
  //     whiteColor = Color(0xFFFFFFFF), // White
  //     blackColor = Color(0xFF000000),
  //     dimGrayColor = Color(0xFF2E2E2E),
  //     darkGrayColor = Color(0xFF333333),
  //     darkGray = Color(0xFF6C757D), // Dark Gray
  //     whiteGray = Color(0xFFD6D6D6), // White Gray
  //     orangeGradientLight = Color(0xFFFF7043), // Lighter Orange from gradient
  //     pinkAccent = Color(0xFFC2185B), // Pinkish-red accent from logo
  //     purpleAccent = Color(0xFF8E24AA); // Purple accent from gradient



  static const String logo_tile = 'assets/logo_title.png',
      working = 'assets/working.gif';
}
