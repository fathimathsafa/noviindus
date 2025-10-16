import 'package:flutter/material.dart';
import 'dart:io';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/add_header.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/dashed_pick_box.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/description_section.dart';
import 'package:noviindus/presentation/add_video_screen/widgets/categories_section.dart';
import 'package:image_picker/image_picker.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _video;
  XFile? _thumbnail;

  Future<void> _pickVideo() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery, maxDuration: const Duration(minutes: 5));
    if (file != null) {
      setState(() => _video = file);
    }
  }

  Future<void> _pickThumbnail() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _thumbnail = file);
    }
  }

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
            AddHeader(onShare: () {
              // TODO: handle submit
            }),
            SizedBox(height: SizeConstants.height(2.5)),
            _video == null
                ? DashedPickBox(
                    icon: Icons.upload,
                    label: 'Select a video from Gallery',
                    heightPercent: 28,
                    onTap: _pickVideo,
                  )
                : _PickedPreview(path: _video!.path, heightPercent: 28, isVideo: true),
            SizedBox(height: SizeConstants.height(2.5)),
            _thumbnail == null
                ? DashedPickBox(
                    icon: Icons.image_outlined,
                    label: 'Add a Thumbnail',
                    heightPercent: 14,
                    onTap: _pickThumbnail,
                  )
                : _PickedPreview(path: _thumbnail!.path, heightPercent: 14),
            SizedBox(height: SizeConstants.height(2.5)),
            DescriptionSection(
              title: 'Add Description',
              hint:
                  'Lorem ipsum dolor sit amet consectetur. Congue nec lectus eget fringilla urna viverra integer justo vitae. Tincidunt cum pellentesque ipsum mi. Posuere at diam lorem est pharetra. Ac suspendisse lorem vel vestibulum non volutpat faucibus',
            ),
            SizedBox(height: SizeConstants.height(2.5)),
            const CategoriesSection(),
            SizedBox(height: SizeConstants.height(4)),
            SizedBox(height: SizeConstants.height(2)),
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


