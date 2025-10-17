import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/core/constant/size_constants.dart';
import 'package:noviindus/presentation/my_feed_screen/provider/my_feed_provider.dart';
import 'package:noviindus/presentation/my_feed_screen/widgets/header.dart';
import 'package:noviindus/presentation/my_feed_screen/widgets/feed_post.dart';

class MyFeedScreen extends StatelessWidget {
  const MyFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConstants.init(context);

    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: const _MyFeedBody(),
      ),
    );
  }
}

class _MyFeedBody extends StatefulWidget {
  const _MyFeedBody();
  @override
  State<_MyFeedBody> createState() => _MyFeedBodyState();
}

class _MyFeedBodyState extends State<_MyFeedBody> {
  final ScrollController _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Provider.of<MyFeedProvider>(context, listen: false).refresh();
      }
    });
    _scroll.addListener(() {
      if (mounted) {
        final c = Provider.of<MyFeedProvider>(context, listen: false);
        if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
          c.loadMore();
        }
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  String _formatTimeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<MyFeedProvider>(context);
    
    print('📱 MyFeedScreen: Building with isLoading: ${c.isLoading}, itemsCount: ${c.items.length}, error: ${c.errorMessage}');
    
    return RefreshIndicator(
      onRefresh: () => c.refresh(),
      child: ListView(
        controller: _scroll,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConstants.width(3.5),
          vertical: SizeConstants.height(1.5),
        ),
        children: [
          const Header(title: 'My Feed'),
          SizedBox(height: SizeConstants.height(2)),
          
          // Error state
          if (c.errorMessage != null)
            Container(
              padding: EdgeInsets.all(SizeConstants.width(3)),
              margin: EdgeInsets.only(bottom: SizeConstants.height(2)),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(SizeConstants.width(2)),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: SizeConstants.width(6)),
                  SizedBox(height: SizeConstants.height(1)),
                  Text(
                    'Failed to load feed',
                    style: TextStyle(
                      color: Colors.red.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: SizeConstants.height(0.5)),
                  Text(
                    c.errorMessage!,
                    style: TextStyle(color: Colors.red.shade600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConstants.height(1)),
                  ElevatedButton(
                    onPressed: () => c.refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          
          // Loading state
          if (c.isLoading && c.items.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            ),
          
          // Empty state
          if (!c.isLoading && c.items.isEmpty && c.errorMessage == null)
            Container(
              padding: EdgeInsets.all(SizeConstants.width(4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feed_outlined, color: Colors.grey, size: SizeConstants.width(8)),
                  SizedBox(height: SizeConstants.height(2)),
                  Text(
                    'No posts yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: SizeConstants.height(1)),
                  Text(
                    'Start creating content to see it here',
                    style: TextStyle(color: Colors.grey.shade500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          
          // Feed items
          for (int i = 0; i < c.items.length; i++) ...[
            FeedPost(
              authorName: (c.items[i].user?.name ?? 'Unknown').toString(),
              timeAgo: _formatTimeAgo(c.items[i].createdAt),
              description: c.items[i].description ?? '',
              imageUrl: c.items[i].image,
              videoUrl: c.items[i].video,
              showSeeMore: false,
              index: i,
              onPlayVideo: () {
                if (c.items[i].video != null && c.items[i].video!.isNotEmpty) {
                  c.playVideo(i, c.items[i].video!);
                }
              },
              isVideoPlaying: c.isVideoPlaying(i),
              videoController: c.videoPlayerController,
            ),
            SizedBox(height: SizeConstants.height(2)),
          ],
          
          // Load more indicator
          if (c.isLoadingMore)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            ),
          
          SizedBox(height: SizeConstants.height(3)),
        ],
      ),
    );
  }
}


