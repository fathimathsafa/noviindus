import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noviindus/data/repositories/feed_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddVideoProvider extends ChangeNotifier {
  final FeedService _feedService = FeedService();
  final ImagePicker _imagePicker = ImagePicker();
  final TextEditingController descController = TextEditingController();
  
  File? video;
  File? thumbnail;
  List<int> selectedCategoryIds = [];
  
  bool isUploading = false;
  double uploadProgress = 0.0;
  String? errorMessage;

  Future<void> pickVideo() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 5),
      );
      
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (pickedFile.path.toLowerCase().endsWith('.mp4')) {
          video = file;
          errorMessage = null;
        } else {
          errorMessage = 'Please select an MP4 video file';
        }
      }
    } catch (e) {
      errorMessage = 'Error picking video: $e';
    }
    notifyListeners();
  }

  Future<void> pickThumbnail() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      
      if (pickedFile != null) {
        thumbnail = File(pickedFile.path);
        errorMessage = null;
      }
    } catch (e) {
      errorMessage = 'Error picking thumbnail: $e';
    }
    notifyListeners();
  }

  void toggleCategory(int categoryId) {
    if (selectedCategoryIds.contains(categoryId)) {
      selectedCategoryIds.remove(categoryId);
    } else {
      selectedCategoryIds.add(categoryId);
    }
    notifyListeners();
  }

  bool get isValid {
    return video != null && 
           thumbnail != null && 
           descController.text.isNotEmpty && 
           selectedCategoryIds.isNotEmpty;
  }

  Future<void> submit(BuildContext context) async {
    if (!isValid) {
      errorMessage = 'Please complete all fields';
      notifyListeners();
      return;
    }

    isUploading = true;
    uploadProgress = 0.0;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      
      if (token == null) {
        throw Exception('Not authenticated');
      }

      await _feedService.uploadMyFeed(
        accessToken: token,
        desc: descController.text,
        categoryIds: selectedCategoryIds,
        videoPath: video!.path,
        imagePath: thumbnail!.path,
        onProgress: (sent, total) {
          uploadProgress = sent / total;
          notifyListeners();
        },
      );

      // Clear form on success
      video = null;
      thumbnail = null;
      descController.clear();
      selectedCategoryIds.clear();
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video uploaded successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isUploading = false;
      uploadProgress = 0.0;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }
}
