import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';

class CountryCodeField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double fieldHeight = SizeConstants.height(7);
    return Container(
      height: fieldHeight,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.width(3),
      ),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(SizeConstants.width(3)),
        border: Border.all(color: ColorConstants.stroke),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('+91', style: TextStyleConstants.input(context)),
          SizedBox(width: SizeConstants.width(1.5)),
          Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
            size: SizeConstants.width(3.8),
          ),
        ],
      ),
    );
  }
}