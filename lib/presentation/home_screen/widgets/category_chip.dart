import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/home_screen/provider/home_provider.dart';

class CategoryChips extends StatefulWidget {
  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int? _selectedId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🏷️ CategoryChips: didChangeDependencies called');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        print('🏷️ CategoryChips: Calling loadCategories()...');
        Provider.of<HomeProvider>(context, listen: false).loadCategories();
      } else {
        print('🏷️ CategoryChips: Widget not mounted, skipping loadCategories()');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeProvider>(context);
    final double chipRadius = SizeConstants.width(6);
    
    print('🏷️ CategoryChips: Building with categories: ${controller.categories.length}, isLoading: ${controller.isLoadingCategories}, error: ${controller.categoryErrorMessage}');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final c in controller.categories)
            Padding(
              padding: EdgeInsets.only(right: SizeConstants.width(3)),
              child: GestureDetector(
                onTap: () => setState(() => _selectedId = c.id),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConstants.width(4),
                    vertical: SizeConstants.height(1.2),
                  ),
                  decoration: BoxDecoration(
                    color: _selectedId == c.id ? ColorConstants.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(chipRadius),
                    border: Border.all(
                      color: _selectedId == c.id ? ColorConstants.primary : ColorConstants.stroke,
                    ),
                  ),
                  child: Text(
                    c.title ?? '',
                    style: TextStyleConstants.bodyM(context).copyWith(
                      color: _selectedId == c.id ? ColorConstants.onPrimary : ColorConstants.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          if (controller.isLoadingCategories)
            const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)),
        ],
      ),
    );
  }
}
