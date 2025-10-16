import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';

class TextStyleConstants {
  TextStyleConstants._();

  static TextStyle headingXL(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: SizeConstants.font(4.3),
      fontWeight: FontWeight.w500,
      color: ColorConstants.textPrimary,
      height: 1.2,
    );
  }

  static TextStyle bodyM(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: SizeConstants.font(2.8),
      fontWeight: FontWeight.w400,
      color: ColorConstants.textSecondary,
      height: 1.5,
    );
  }

  static TextStyle buttonL(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: SizeConstants.font(3.8),
      fontWeight: FontWeight.w600,
      color: ColorConstants.onPrimary,
      letterSpacing: 0.3,
    );
  }

  static TextStyle input(BuildContext context) {
    return GoogleFonts.montserrat(
      fontSize: SizeConstants.font(3),
      fontWeight: FontWeight.w500,
      color: ColorConstants.textPrimary,
    );
  }
}


