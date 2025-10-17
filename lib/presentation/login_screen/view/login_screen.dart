import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/login_screen/provider/auth_provider.dart';
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
                    SizedBox(height: SizeConstants.height(3)),
                    // Error message display
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        if (authProvider.errorMessage != null) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(SizeConstants.width(3)),
                            margin: EdgeInsets.only(bottom: SizeConstants.height(2)),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(SizeConstants.width(2)),
                              border: Border.all(color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Text(
                              authProvider.errorMessage!,
                              style: TextStyleConstants.bodyM(context).copyWith(
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    SizedBox(height: SizeConstants.height(20)),
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


