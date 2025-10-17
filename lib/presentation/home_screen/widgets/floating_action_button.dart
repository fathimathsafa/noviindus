import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/presentation/add_video_screen/view/add_video_screen.dart';

class AddFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double size = SizeConstants.height(7.5);
    return SizedBox(
      height: size,
      width: size,
      child: FloatingActionButton(
        backgroundColor: ColorConstants.primary,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVideoScreen()));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}