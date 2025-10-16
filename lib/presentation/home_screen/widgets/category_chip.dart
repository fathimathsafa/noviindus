import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/home_screen/controller/home_controller.dart';

class CategoryChips extends StatefulWidget {
  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int? _selectedId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeControllerProvider.of(context).loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = HomeControllerProvider.of(context);
    final double chipRadius = SizeConstants.width(6);

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
          if (controller.isLoading)
            const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)),
        ],
      ),
    );
  }
}
