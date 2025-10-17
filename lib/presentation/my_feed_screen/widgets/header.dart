import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);

          },
          child: Container(
          height: SizeConstants.height(4.2),
          width: SizeConstants.height(4.2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorConstants.stroke),
          ),
          child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white),
        ),

        ),
       
        SizedBox(width: SizeConstants.width(3)),
        Text(title, style: TextStyleConstants.headingXL(context)),
      ],
    );
  }
}


