import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:noviindus/presentation/home_screen/controller/home_controller.dart';
import 'package:video_player/video_player.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final controller = HomeControllerProvider.of(context);
    final item = controller.home?.results?[index];
    final bool isPlaying = controller.playingIndex == index && controller.videoController?.value.isInitialized == true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: SizeConstants.width(5),
              backgroundColor: ColorConstants.surface,
              backgroundImage: AssetImage("assets/postprofile.png"),
            ),
            SizedBox(width: SizeConstants.width(3)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item?.user?.name ?? 'User', style: TextStyleConstants.input(context)),
                  SizedBox(height: SizeConstants.height(0.5)),
                  Text('5 days ago', style: TextStyleConstants.bodyM(context)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConstants.height(2)),
        AspectRatio(
          aspectRatio: isPlaying && controller.videoController!.value.isInitialized
              ? controller.videoController!.value.aspectRatio
              : 3 / 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SizeConstants.width(3)),
            child: isPlaying
                ? _VideoPlayer(controller: controller.videoController!)
                : _ThumbnailOverlay(
                    imageUrl: item?.image,
                    onPlay: () => controller.playAt(index),
                  ),
          ),
        ),
        SizedBox(height: SizeConstants.height(2)),
        Text(item?.description ?? '', style: TextStyleConstants.bodyM(context).copyWith(color: ColorConstants.textPrimary)),
      ],
    );
  }
}

class _ThumbnailOverlay extends StatelessWidget {
  const _ThumbnailOverlay({this.imageUrl, required this.onPlay});

  final String? imageUrl;
  final VoidCallback onPlay;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(imageUrl!, fit: BoxFit.cover)
            : Container(color: ColorConstants.surface),
        Center(
          child: GestureDetector(
            onTap: onPlay,
            child: Container(
              height: SizeConstants.height(7),
              width: SizeConstants.height(7),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white24),
              child: Icon(Icons.play_arrow, color: Colors.white, size: SizeConstants.height(4.5)),
            ),
          ),
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  const _VideoPlayer({required this.controller});
  final VideoPlayerController controller;
  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    final vc = widget.controller;
    return Stack(
      fit: StackFit.expand,
      children: [
        VideoPlayer(vc),
        Align(
          alignment: Alignment.bottomCenter,
          child: _Controls(controller: vc),
        ),
      ],
    );
  }
}

class _Controls extends StatefulWidget {
  const _Controls({required this.controller});
  final VideoPlayerController controller;
  @override
  State<_Controls> createState() => _ControlsState();
}

class _ControlsState extends State<_Controls> {
  String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return h > 0 ? '${two(h)}:${two(m)}:${two(s)}' : '${two(m)}:${two(s)}';
  }

  @override
  Widget build(BuildContext context) {
    final vc = widget.controller;
    return SizedBox(
      height: SizeConstants.height(6),
      child: Container(
        color: Colors.black45,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.width(3),
          vertical: SizeConstants.height(0.8),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(vc.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
              onPressed: () {
                setState(() {
                  vc.value.isPlaying ? vc.pause() : vc.play();
                });
              },
            ),
            Expanded(
              child: VideoProgressIndicator(
                vc,
                allowScrubbing: true,
                colors: VideoProgressColors(playedColor: ColorConstants.primary, backgroundColor: Colors.white24),
              ),
            ),
            SizedBox(width: SizeConstants.width(2)),
            Text(_fmt(vc.value.position), style: const TextStyle(color: Colors.white)),
            const Text(' / ', style: TextStyle(color: Colors.white70)),
            Text(_fmt(vc.value.duration), style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}