import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/presentation/home_screen/widgets/category_chip.dart';
import 'package:noviindus/presentation/home_screen/widgets/floating_action_button.dart';
import 'package:noviindus/presentation/home_screen/widgets/header.dart';
import 'package:noviindus/presentation/home_screen/widgets/post_card.dart';
import 'package:noviindus/presentation/home_screen/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConstants.init(context);

    final controller = HomeController();
    return Scaffold(
      backgroundColor: ColorConstants.background,
      floatingActionButton: AddFab(),
      body: SafeArea(
        child: HomeControllerProvider(
          controller: controller,
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
            _HomeFeedList(),
            SizedBox(height: SizeConstants.height(2)),
           
          ],
        ),
        ),
      ),
    );
  }
}

class _HomeFeedList extends StatefulWidget {
  @override
  State<_HomeFeedList> createState() => _HomeFeedListState();
}

class _HomeFeedListState extends State<_HomeFeedList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeControllerProvider.of(context).loadHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = HomeControllerProvider.of(context);
    final results = controller.home?.results ?? [];
    if (controller.isLoading && results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.errorMessage != null) {
      return Text(controller.errorMessage!, style: const TextStyle(color: Colors.redAccent));
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












