import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:noviindus/core/config/app_config.dart';

class FeedService {
  final String baseUrl;
  final http.Client client;
  
  FeedService({
    this.baseUrl = AppConfig.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<void> uploadMyFeed({
    required String accessToken,
    required String desc,
    required List<int> categoryIds,
    required String videoPath,
    required String imagePath,
    void Function(int sent, int total)? onProgress,
  }) async {
    final uri = Uri.parse('$baseUrl${AppConfig.uploadFeedEndpoint}');
    
    // Create multipart request
    final request = http.MultipartRequest('POST', uri);
    
    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer $accessToken',
    });
    
    // Add form fields
    request.fields['desc'] = desc;
    request.fields['category'] = jsonEncode(categoryIds);
    
    // Add video file
    final videoFile = File(videoPath);
    if (await videoFile.exists()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'video',
          videoPath,
          filename: 'video.mp4',
        ),
      );
    }
    
    // Add image file
    final imageFile = File(imagePath);
    if (await imageFile.exists()) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath,
          filename: 'thumb.jpg',
        ),
      );
    }
    
    // Send request with progress tracking
    final streamedResponse = await client.send(request);
    
    // Handle progress if callback provided
    if (onProgress != null) {
      int sent = 0;
      int total = streamedResponse.contentLength ?? 0;
      
      streamedResponse.stream.listen(
        (chunk) {
          sent += chunk.length;
          onProgress(sent, total);
        },
        onDone: () {
          onProgress(total, total);
        },
      );
    }
    
    final response = await http.Response.fromStream(streamedResponse);
    
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Upload failed (${response.statusCode}): ${response.body}');
    }
  }

  void dispose() {
    client.close();
  }
}


