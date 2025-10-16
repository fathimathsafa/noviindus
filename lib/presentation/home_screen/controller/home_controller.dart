import 'package:flutter/material.dart';
import 'package:noviindus/data/model/category_list_model.dart';
import 'package:noviindus/data/repositories/home_service.dart';
import 'package:noviindus/data/model/home_model.dart';
import 'package:video_player/video_player.dart';

class HomeController extends ChangeNotifier {
  HomeController({HomeService? service}) : _service = service ?? HomeService();

  final HomeService _service;
  List<Category> categories = [];
  HomeModel? home;
  bool isLoading = false;
  String? errorMessage;
  int? playingIndex;
  VideoPlayerController? videoController;

  Future<void> loadCategories() async {
    if (categories.isNotEmpty || isLoading) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final model = await _service.fetchCategories();
      categories = model.categories ?? [];
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadHome() async {
    if (home != null || isLoading) return;
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      home = await _service.fetchHome();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> playAt(int index) async {
    if (home == null || index < 0 || index >= (home!.results?.length ?? 0)) return;
    final item = home!.results![index];
    final url = item.video;
    if (url == null || url.isEmpty) return;
    // stop existing
    await videoController?.pause();
    await videoController?.dispose();
    videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoController!.initialize();
    await videoController!.play();
    playingIndex = index;
    notifyListeners();
  }

  Future<void> pause() async {
    await videoController?.pause();
    notifyListeners();
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }
}

class HomeControllerProvider extends InheritedNotifier<HomeController> {
  const HomeControllerProvider({super.key, required HomeController controller, required Widget child})
      : super(notifier: controller, child: child);

  static HomeController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<HomeControllerProvider>();
    assert(provider != null, 'HomeControllerProvider not found in context');
    return provider!.notifier!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<HomeController> oldWidget) => true;
}


