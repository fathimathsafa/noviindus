import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/core/constant/color_constants.dart';

class DashedPickBox extends StatelessWidget {
  const DashedPickBox({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.heightPercent = 20,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double heightPercent; // percentage of screen height

  @override
  Widget build(BuildContext context) {
    final double h = SizeConstants.height(heightPercent);
    final radius = SizeConstants.width(3);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: CustomPaint(
        painter: _DashedRRectPainter(
          color: ColorConstants.stroke,
          dashWidth: 6,
          dashGap: 6,
          strokeWidth: 1,
          radius: radius,
        ),
        child: Container(
          height: h,
          decoration: BoxDecoration(
            color: ColorConstants.surface,
            borderRadius: BorderRadius.circular(radius),
          ),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white70,
                  size: h * 0.35,
                ),
                SizedBox(height: h * 0.08),
                Text(
                  label,
                  style: TextStyleConstants.bodyM(context).copyWith(
                    color: ColorConstants.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  _DashedRRectPainter({
    required this.color,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
    required this.radius,
  });

  final Color color;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Path path = Path()..addRRect(rect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double next = distance + dashWidth;
        final Path extractPath = metric.extractPath(distance, next);
        canvas.drawPath(extractPath, paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


