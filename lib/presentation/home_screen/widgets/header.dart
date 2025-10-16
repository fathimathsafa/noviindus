import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello Maria', style: TextStyleConstants.headingXL(context)),
              SizedBox(height: SizeConstants.height(0.7)),
              Text('Welcome back to Section', style: TextStyleConstants.bodyM(context)),
            ],
          ),
        ),
        CircleAvatar(
          radius: SizeConstants.width(5.5),
          backgroundColor: ColorConstants.surface,
          child: CircleAvatar(
            radius: SizeConstants.width(5),
            backgroundImage: const AssetImage('assets/profile.jpg'),
            onBackgroundImageError: (_, __) {},
          ),
        ),
      ],
    );
  }
}