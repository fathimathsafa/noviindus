import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';

class AddHeader extends StatelessWidget {
  const AddHeader({super.key, this.onShare});

  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: SizeConstants.height(4.2),
          width: SizeConstants.height(4.2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorConstants.stroke),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white),
        ),
        SizedBox(width: SizeConstants.width(3)),
        Expanded(child: Text('Add Feeds', style: TextStyleConstants.headingXL(context))),
        GestureDetector(
          onTap: onShare,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConstants.width(4.5),
              vertical: SizeConstants.height(1.2),
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: ColorConstants.primary),
              borderRadius: BorderRadius.circular(SizeConstants.height(3)),
            ),
            child: Text(
              'Share Post',
              style: TextStyleConstants.bodyM(context).copyWith(
                color: ColorConstants.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}



