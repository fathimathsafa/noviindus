import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/login_screen/provider/auth_provider.dart';

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = SizeConstants.height(6.5);
    final double radius = height / 2;
        final controller = Provider.of<AuthProvider>(context);
    return GestureDetector(
      onTap: controller.isLoading ? null : () => controller.login(context),
      child: Container(
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: ColorConstants.stroke),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConstants.width(5),
              vertical: SizeConstants.height(1.8),
            ),
            child: controller.isLoading
                ? SizedBox(
                    width: SizeConstants.width(6),
                    height: SizeConstants.height(2.8),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text('Continue', style: TextStyleConstants.buttonL(context)),
          ),
          Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              color: ColorConstants.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    ),
  );
  }
}