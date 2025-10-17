import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/core/constant/text_style_constants.dart';
import 'package:video_player/video_player.dart';

class FeedPost extends StatelessWidget {
  const FeedPost({
    super.key,
    required this.authorName,
    required this.timeAgo,
    required this.description,
    this.image,
    this.imageUrl,
    this.videoUrl,
    this.showSeeMore = false,
    this.index = 0,
    this.onPlayVideo,
    this.isVideoPlaying = false,
    this.videoController,
  });

  final String authorName;
  final String timeAgo;
  final String description;
  final File? image;
  final String? imageUrl;
  final String? videoUrl;
  final bool showSeeMore;
  final int index;
  final VoidCallback? onPlayVideo;
  final bool isVideoPlaying;
  final VideoPlayerController? videoController;

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
              backgroundImage: AssetImage("assets/postprofile.png"),
            ),
            SizedBox(width: SizeConstants.width(3)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(authorName, style: TextStyleConstants.input(context)),
                  SizedBox(height: SizeConstants.height(0.6)),
                  Text(timeAgo, style: TextStyleConstants.bodyM(context)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConstants.height(1.5)),
        ClipRRect(
          borderRadius: BorderRadius.circular(SizeConstants.width(3)),
          child: AspectRatio(
            aspectRatio: isVideoPlaying && videoController?.value.isInitialized == true
                ? videoController!.value.aspectRatio
                : 3 / 4,
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Display video player if playing, otherwise show image
                if (isVideoPlaying && videoController != null && videoController!.value.isInitialized)
                  VideoPlayer(videoController!)
                else if (image != null)
                  Image.file(image!, fit: BoxFit.cover)
                else if (imageUrl != null && imageUrl!.isNotEmpty)
                  Image.network(imageUrl!, fit: BoxFit.cover)
                else
                  Container(color: ColorConstants.surface),
                
                // Show play button if there's a video and not playing
                if (videoUrl != null && videoUrl!.isNotEmpty && !isVideoPlaying)
                  Center(
                    child: GestureDetector(
                      onTap: onPlayVideo,
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
                  ),
                
                // Show pause button if video is playing
                if (isVideoPlaying && videoController != null && videoController!.value.isInitialized)
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (videoController!.value.isPlaying) {
                          videoController!.pause();
                        } else {
                          videoController!.play();
                        }
                      },
                      child: Container(
                        height: SizeConstants.height(7),
                        width: SizeConstants.height(7),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: Icon(
                          videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: SizeConstants.height(4.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: SizeConstants.height(1.5)),
        RichText(
          text: TextSpan(
            style: TextStyleConstants.bodyM(context).copyWith(color: ColorConstants.textPrimary),
            children: [
              TextSpan(text: description),
              if (showSeeMore)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.only(left: SizeConstants.width(1)),
                    child: Text(
                      'See More',
                      style: TextStyleConstants.bodyM(context).copyWith(
                        color: ColorConstants.onPrimary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: SizeConstants.height(2)),
        Divider(color: ColorConstants.stroke),
      ],
    );
  }
}


