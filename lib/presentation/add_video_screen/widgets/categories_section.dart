import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/presentation/add_video_screen/provider/add_video_provider.dart';
import 'package:noviindus/data/repositories/home_service.dart';
import 'package:noviindus/data/model/category_list_model.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final HomeService _service = HomeService();
  List<Category> _categories = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final model = await _service.fetchCategories();
      setState(() => _categories = model.categories ?? []);
    } catch (_) {
      // ignore error; UI will show nothing
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = _categories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Categories This Project', style: TextStyleConstants.input(context)),
            ),
            Text('View All', style: TextStyleConstants.bodyM(context)),
            SizedBox(width: SizeConstants.width(1)),
            const Icon(Icons.info_outline, size: 16, color: Colors.white70),
          ],
        ),
        SizedBox(height: SizeConstants.height(1.5)),
        Wrap(
          spacing: SizeConstants.width(2),
          runSpacing: SizeConstants.height(1.2),
          children: [
            if (_loading)
              const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2))
            else
            for (final c in categories)
              GestureDetector(
                onTap: () {
                  final ctrl = Provider.of<AddVideoProvider>(context, listen: false);
                  final id = c.id ?? categories.indexOf(c);
                  ctrl.toggleCategory(id);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConstants.width(3),
                    vertical: SizeConstants.height(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: Provider.of<AddVideoProvider>(context).selectedCategoryIds.contains(c.id ?? categories.indexOf(c))
                        ? ColorConstants.primary.withOpacity(0.15)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(SizeConstants.width(5)),
                    border: Border.all(
                        color: Provider.of<AddVideoProvider>(context).selectedCategoryIds.contains(c.id ?? categories.indexOf(c))
                            ? ColorConstants.primary
                            : ColorConstants.stroke),
                  ),
                  child: Text(
                    c.title ?? '',
                    style: TextStyleConstants.bodyM(context).copyWith(
                      color: ColorConstants.textPrimary,
                      fontWeight: Provider.of<AddVideoProvider>(context)
                              .selectedCategoryIds
                              .contains(c.id ?? categories.indexOf(c))
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}



            