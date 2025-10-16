import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/login_screen/widgets/continue_button.dart';
import 'package:noviindus/presentation/login_screen/widgets/country_code_filed.dart';
import 'package:noviindus/presentation/login_screen/widgets/phone_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConstants.init(context);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConstants.width(6),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConstants.height(6)),
                    Text('Enter Your', style: TextStyleConstants.headingXL(context)),
                    Text('Mobile Number', style: TextStyleConstants.headingXL(context)),
                    SizedBox(height: SizeConstants.height(2.5)),
                    SizedBox(
                      width: SizeConstants.width(90),
                      child: Text(
                        'Lorem ipsum dolor sit amet consectetur. Porta at id hac vitae. Et tortor at vehicula euismod mi viverra.',
                        style: TextStyleConstants.bodyM(context),
                        softWrap: true,
                      ),
                    ),
                    SizedBox(height: SizeConstants.height(5)),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CountryCodeField(),
                        ),
                        SizedBox(width: SizeConstants.width(3)),
                        Expanded(
                          flex: 10,
                          child: PhoneField(),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConstants.height(25)),
                    Align(
                      alignment: Alignment.center,
                      child: ContinueButton(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


