import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/presentation/add_video_screen/provider/add_video_provider.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/add_header.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/dashed_pick_box.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/description_section.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/categories_section.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConstants.init(context);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.width(4),
            vertical: SizeConstants.height(2),
          ),
          children: [
            Consumer<AddVideoProvider>(
              builder: (context, controller, _) => AddHeader(onShare: () => controller.submit(context)),
            ),
            SizedBox(height: SizeConstants.height(2.5)),
            Consumer<AddVideoProvider>(
              builder: (context, controller, _) => controller.video == null
                  ? DashedPickBox(
                      icon: Icons.upload,
                      label: 'Select a video from Gallery',
                      heightPercent: 28,
                      onTap: controller.pickVideo,
                    )
                  : _PickedPreview(path: controller.video!.path, heightPercent: 28, isVideo: true),
            ),
            SizedBox(height: SizeConstants.height(2.5)),
            Consumer<AddVideoProvider>(
              builder: (context, controller, _) => controller.thumbnail == null
                  ? DashedPickBox(
                      icon: Icons.image_outlined,
                      label: 'Add a Thumbnail',
                      heightPercent: 14,
                      onTap: controller.pickThumbnail,
                    )
                  : _PickedPreview(path: controller.thumbnail!.path, heightPercent: 14),
            ),
            SizedBox(height: SizeConstants.height(2.5)),
            Consumer<AddVideoProvider>(
              builder: (context, controller, _) => DescriptionSection(
                title: 'Add Description',
                hint:
                    'Lorem ipsum dolor sit amet consectetur. Congue nec lectus eget fringilla urna viverra integer justo vitae. Tincidunt cum pellentesque ipsum mi. Posuere at diam lorem est pharetra. Ac suspendisse lorem vel vestibulum non volutpat faucibus',
                textController: controller.descController,
              ),
            ),
            SizedBox(height: SizeConstants.height(2.5)),
            const CategoriesSection(),
            SizedBox(height: SizeConstants.height(4)),
            _UploadProgressBar(),
            _ErrorConsolePrinter(),
          ],
        ),
      ),
    );
    
  }
}

class _PickedPreview extends StatelessWidget {
  const _PickedPreview({required this.path, required this.heightPercent, this.isVideo = false});

  final String path;
  final double heightPercent;
  final bool isVideo;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConstants.height(heightPercent),
      decoration: BoxDecoration(
        color: ColorConstants.surface,
        borderRadius: BorderRadius.circular(SizeConstants.width(3)),
        border: Border.all(color: ColorConstants.stroke),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(File(path), fit: BoxFit.cover),
          if (isVideo)
            Center(
              child: Container(
                height: SizeConstants.height(7),
                width: SizeConstants.height(7),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
                child: Icon(Icons.play_arrow, color: Colors.white, size: SizeConstants.height(4.5)),
              ),
            ),
        ],
      ),
    );
  }
}

class _UploadProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Provider.of<AddVideoProvider>(context);
    if (!c.isUploading) return const SizedBox.shrink();
    return LinearProgressIndicator(value: c.uploadProgress);
  }
}

class _ErrorConsolePrinter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Provider.of<AddVideoProvider>(context);
    if (c.errorMessage != null && c.errorMessage!.isNotEmpty) {
      // Print the latest error to the console for debugging
      // This will print whenever an error is set on the controller
      // and the widget tree rebuilds.
      // ignore: avoid_print
      print('AddVideoScreen Error: ${c.errorMessage}');
    }
    return const SizedBox.shrink();
  }
}


