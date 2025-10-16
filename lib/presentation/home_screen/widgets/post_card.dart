import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    required this.authorName,
    required this.timeAgo,
    required this.description,
  });

  final String authorName;
  final String timeAgo;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: SizeConstants.width(5),
              backgroundColor: ColorConstants.surface,
            ),
            SizedBox(width: SizeConstants.width(3)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(authorName, style: TextStyleConstants.input(context)),
                  SizedBox(height: SizeConstants.height(0.5)),
                  Text(timeAgo, style: TextStyleConstants.bodyM(context)),
                ],
              ),
            ),
            Icon(Icons.more_horiz, color: ColorConstants.textSecondary),
          ],
        ),
        SizedBox(height: SizeConstants.height(2)),
        ClipRRect(
          borderRadius: BorderRadius.circular(SizeConstants.width(3)),
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(color: ColorConstants.surface),
                Center(
                  child: Container(
                    height: SizeConstants.height(7),
                    width: SizeConstants.height(7),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white24,
                    ),
                    child: Icon(Icons.play_arrow, color: Colors.white, size: SizeConstants.height(4.5)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: SizeConstants.height(2)),
        Text(
          description,
          style: TextStyleConstants.bodyM(context).copyWith(color: ColorConstants.textPrimary),
        ),
      ],
    );
  }
}