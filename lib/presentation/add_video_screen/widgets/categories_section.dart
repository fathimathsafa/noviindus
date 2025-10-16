import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  final Set<String> _selected = <String>{};

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Physics',
      'Artificial Intelligence',
      'Mathematics',
      'Chemistry',
      'Micro Biology',
      'Lorem ipsum dolor sit gre',
    ];

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
            for (final c in categories)
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_selected.contains(c)) {
                      _selected.remove(c);
                    } else {
                      _selected.add(c);
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConstants.width(3),
                    vertical: SizeConstants.height(0.8),
                  ),
                  decoration: BoxDecoration(
                    color: _selected.contains(c) ? ColorConstants.primary.withOpacity(0.15) : Colors.transparent,
                    borderRadius: BorderRadius.circular(SizeConstants.width(5)),
                    border: Border.all(color: _selected.contains(c) ? ColorConstants.primary : ColorConstants.stroke),
                  ),
                  child: Text(
                    c,
                    style: TextStyleConstants.bodyM(context).copyWith(
                      color: ColorConstants.textPrimary,
                      fontWeight: _selected.contains(c) ? FontWeight.w600 : FontWeight.w400,
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



