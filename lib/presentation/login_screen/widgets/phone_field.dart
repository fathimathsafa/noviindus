
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/login_screen/provider/auth_provider.dart';

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
        controller: Provider.of<AuthProvider>(context).phoneController,
        style: TextStyleConstants.input(context),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
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