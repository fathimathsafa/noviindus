import 'package:flutter/material.dart';
import 'package:noviindus/data/model/my_feed_model.dart';
import 'package:noviindus/data/repositories/my_feed_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class MyFeedProvider extends ChangeNotifier {
  late final MyFeedService _myFeedService;
  
  List<Result> items = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  String? errorMessage;
  int _page = 1;
  bool _hasNext = true;
  
  // Video player properties
  VideoPlayerController? videoPlayerController;
  int? playingIndex;

  MyFeedProvider() {
    _myFeedService = MyFeedService();
  }

  Future<void> refresh() async {
    items.clear();
    _page = 1;
    _hasNext = true;
    await loadMore();
  }

  Future<void> loadMore() async {
    if (isLoading || isLoadingMore || !_hasNext) return;
    
    
    if (items.isEmpty) {
      isLoading = true;
    } else {
      isLoadingMore = true;
    }
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      
      if (token == null) {
        throw Exception('Not authenticated');
      }

      final model = await _myFeedService.getMyFeed(accessToken: token, page: _page);
      
      items.addAll(model.results ?? []);
      _hasNext = (model.next != null);
      _page += 1;
      errorMessage = null;
      
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> playVideo(int index, String videoUrl) async {
    if (index < 0 || index >= items.length) return;
    
    // Stop current video if playing
    await videoPlayerController?.pause();
    await videoPlayerController?.dispose();
    
    try {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoPlayerController!.initialize();
      await videoPlayerController!.play();
      
      playingIndex = index;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to play video: $e';
      notifyListeners();
    }
  }
  
  Future<void> pauseVideo() async {
    await videoPlayerController?.pause();
    notifyListeners();
  }
  
  Future<void> stopVideo() async {
    await videoPlayerController?.pause();
    await videoPlayerController?.dispose();
    videoPlayerController = null;
    playingIndex = null;
    notifyListeners();
  }
  
  bool isVideoPlaying(int index) {
    return playingIndex == index && 
           videoPlayerController?.value.isInitialized == true &&
           videoPlayerController!.value.isPlaying;
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    _myFeedService.dispose();
    super.dispose();
  }
}
