import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/presentation/my_feed_screen/widgets/header.dart';
import 'package:noviindus/presentation/my_feed_screen/widgets/feed_post.dart';

class MyFeedScreen extends StatelessWidget {
  const MyFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConstants.init(context);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(3.5),
            vertical: SizeConstants.height(1.5),
          ),
          children: [
            const Header(title: 'My Feed'),
            SizedBox(height: SizeConstants.height(2)),
            const FeedPost(
              authorName: 'Anagha Krishna',
              timeAgo: '5 days ago',
              description:
                  'Lorem ipsum dolor sit amet consectetur. Leo ac lorem faucibus facilisis tellus. At vitae dis commodo nunc sollicitudin elementum suspendisse...',
              showSeeMore: false,
            ),
            SizedBox(height: SizeConstants.height(2.5)),
            const FeedPost(
              authorName: 'Gokul Krishna',
              timeAgo: '5 days ago',
              description:
                  'Lorem ipsum dolor sit amet consectetur. Leo ac lorem faucibus facilisis tellus. At vitae dis commodo nunc sollicitudin elementum suspendisse...',
              showSeeMore: true,
            ),
            SizedBox(height: SizeConstants.height(3)),
          ],
        ),
      ),
    );
  }
}

// old inline widgets moved to widgets/ folder


