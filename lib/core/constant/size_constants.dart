import 'package:flutter/material.dart';

class SizeConstants {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockWidth = screenWidth / 100;   // 1% of screen width
    blockHeight = screenHeight / 100; // 1% of screen height
  }

  // font size relative to screen width
  static double font(double size) {
    return size * blockWidth;
  }

  // height spacing
  static double height(double size) {
    return size * blockHeight;
  }

  // width spacing
  static double width(double size) {
    return size * blockWidth;
  }
}