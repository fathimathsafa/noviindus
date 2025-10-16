import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/home_screen/widgets/category_chip.dart';
import 'package:noviindus/presentation/home_screen/widgets/floating_action_button.dart';
import 'package:noviindus/presentation/home_screen/widgets/header.dart';
import 'package:noviindus/presentation/home_screen/widgets/post_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConstants.init(context);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      floatingActionButton: AddFab(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(4),
            vertical: SizeConstants.height(2),
          ),
          children: [
            Header(),
            SizedBox(height: SizeConstants.height(2)),
            CategoryChips(),
            SizedBox(height: SizeConstants.height(2)),
            PostCard(
              authorName: 'Anagha Krishna',
              timeAgo: '5 days ago',
              description:
                  'Lorem ipsum dolor sit amet consectetur. Leo ac lorem faucibus facilisis tellus. At vitae dis commodo sollicitudin elementum suspendisse...',
            ),
            SizedBox(height: SizeConstants.height(2)),
           
          ],
        ),
      ),
    );
  }
}












