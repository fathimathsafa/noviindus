
import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';

class PhoneField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fieldHeight = SizeConstants.height(7);
    return Container(
      height: fieldHeight,
      padding: EdgeInsets.symmetric(horizontal: SizeConstants.width(4)),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(SizeConstants.width(3)),
        border: Border.all(color: ColorConstants.stroke),
      ),
      child: TextField(
        keyboardType: TextInputType.phone,
        textAlignVertical: TextAlignVertical.center,
        expands: true,
        minLines: null,
        maxLines: null,
        style: TextStyleConstants.input(context),
        decoration: InputDecoration(
          hintText: 'Enter Mobile Number',
          hintStyle: TextStyleConstants.input(context).copyWith(
            color: ColorConstants.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}