import 'package:flutter/material.dart';
import 'package:noviindus/data/model/category_list_model.dart';
import 'package:noviindus/data/model/home_model.dart';
import 'package:noviindus/data/repositories/home_service.dart';
import 'package:video_player/video_player.dart';

class HomeProvider extends ChangeNotifier {
  final HomeService _service;

  HomeProvider({required HomeService service}) : _service = service;

  List<Category> categories = [];
  List<Result> homeFeed = [];
  HomeModel? home;
  bool isLoading = false;
  bool isLoadingHome = false;
  bool isLoadingCategories = false;
  String? errorMessage;
  String? homeErrorMessage;
  String? categoryErrorMessage;
  int? playingIndex;
  VideoPlayerController? videoPlayerController;

  Future<void> loadCategories() async {
    if (isLoadingCategories) return;
    isLoadingCategories = true;
    categoryErrorMessage = null;
    notifyListeners();

    try {
      final model = await _service.fetchCategories();
      categories = model.categories ?? [];
      categoryErrorMessage = null;
    } catch (e) {
      categoryErrorMessage = e.toString();
    } finally {
      isLoadingCategories = false;
      notifyListeners();
    }
  }

  Future<void> loadHome() async {
    if (isLoadingHome) return;
    isLoadingHome = true;
    homeErrorMessage = null;
    notifyListeners();

    try {
      home = await _service.fetchHome();
      homeFeed = home?.results ?? [];
      homeErrorMessage = null;
    } catch (e) {
      homeErrorMessage = e.toString();
    } finally {
      isLoadingHome = false;
      notifyListeners();
    }
  }

  Future<void> playAt(int index, String videoUrl) async {
    if (index < 0 || index >= homeFeed.length) return;
    final item = homeFeed[index];
    final url = item.video;
    if (url == null || url.isEmpty) return;

    await videoPlayerController?.pause();
    await videoPlayerController?.dispose();

    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoPlayerController!.initialize();
    await videoPlayerController!.play();

    playingIndex = index;
    notifyListeners();
  }

  Future<void> pause() async {
    await videoPlayerController?.pause();
    notifyListeners();
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    super.dispose();
  }
}
