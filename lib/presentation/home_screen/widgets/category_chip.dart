import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';

class CategoryChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double chipRadius = SizeConstants.width(6);
    Widget buildChip(String label, {bool selected = false}) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.width(4),
          vertical: SizeConstants.height(1.2),
        ),
        decoration: BoxDecoration(
          color: selected ? ColorConstants.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(chipRadius),
          border: Border.all(
            color: selected ? ColorConstants.primary : ColorConstants.stroke,
          ),
        ),
        child: Text(
          label,
          style: TextStyleConstants.bodyM(context).copyWith(
            color: selected ? ColorConstants.onPrimary : ColorConstants.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          buildChip('Explore', selected: true),
          SizedBox(width: SizeConstants.width(3)),
          buildChip('Trending'),
          SizedBox(width: SizeConstants.width(3)),
          buildChip('All Categories'),
          SizedBox(width: SizeConstants.width(3)),
          buildChip('Photos'),
        ],
      ),
    );
  }
}
