import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key, required this.title, required this.hint});

  final String title;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final double radius = SizeConstants.width(3);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyleConstants.input(context)),
        SizedBox(height: SizeConstants.height(1)),
        Container(
          padding: EdgeInsets.all(SizeConstants.width(3)),
          decoration: BoxDecoration(
            color: ColorConstants.surface,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: TextField(
            maxLines: 6,
            minLines: 4,
            style: TextStyleConstants.bodyM(context).copyWith(color: ColorConstants.textPrimary),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyleConstants.bodyM(context),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}




