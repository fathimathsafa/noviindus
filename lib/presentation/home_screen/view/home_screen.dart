import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/home_screen/provider/home_provider.dart';
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
            HomeFeedList(),
            SizedBox(height: SizeConstants.height(3)),
            // Bottom categories row reused
            CategoryChips(),
            SizedBox(height: SizeConstants.height(2)),
          ],
        ),
      ),
    );
  }
}

class HomeFeedList extends StatefulWidget {
  @override
  State<HomeFeedList> createState() => _HomeFeedListState();
}

class _HomeFeedListState extends State<HomeFeedList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<HomeProvider>(context, listen: false).loadHome();
      } else {
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeProvider>(context);
    final results = controller.homeFeed;
    
    
    if (controller.isLoadingHome && results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (controller.homeErrorMessage != null) {
      return Container(
        padding: EdgeInsets.all(SizeConstants.width(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: SizeConstants.width(8)),
            SizedBox(height: SizeConstants.height(2)),
            Text(
              'Failed to load content',
              style: TextStyleConstants.headingXL(context).copyWith(color: Colors.red),
            ),
            SizedBox(height: SizeConstants.height(1)),
            Text(
              controller.homeErrorMessage!,
              style: TextStyleConstants.bodyM(context).copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: SizeConstants.height(2)),
            ElevatedButton(
              onPressed: () => controller.loadHome(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    if (results.isEmpty) {
      return Container(
        padding: EdgeInsets.all(SizeConstants.width(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.feed_outlined, color: Colors.grey, size: SizeConstants.width(8)),
            SizedBox(height: SizeConstants.height(2)),
            Text(
              'No content available',
              style: TextStyleConstants.headingXL(context).copyWith(color: Colors.grey),
            ),
            SizedBox(height: SizeConstants.height(1)),
            Text(
              'Check back later for new posts',
              style: TextStyleConstants.bodyM(context).copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return Column(
      children: [
        for (int i = 0; i < results.length; i++) ...[
          PostCard(index: i),
          SizedBox(height: SizeConstants.height(2)),
        ]
      ],
    );
  }
}












