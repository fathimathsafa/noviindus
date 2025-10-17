import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noviindus/core/config/app_config.dart';
import 'package:noviindus/core/utils/network_utils.dart';
import 'package:noviindus/data/model/my_feed_model.dart';

class MyFeedService {
  final String baseUrl;
  final http.Client client;
  
  MyFeedService({
    this.baseUrl = AppConfig.baseUrl,
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<MyFeedModel> getMyFeed({required String accessToken, int page = 1}) async {
    int retryCount = 0;
    const maxRetries = 3;
    
    while (retryCount < maxRetries) {
      try {
        print('🌐 MyFeedService: Starting getMyFeed... (attempt ${retryCount + 1}/$maxRetries)');
        final uri = Uri.parse('$baseUrl${AppConfig.myFeedEndpoint}').replace(
          queryParameters: {'page': page.toString()},
        );
        
        print('🌐 MyFeedService: Requesting URL: $uri');
        print('🌐 MyFeedService: Headers: Authorization: Bearer [HIDDEN]');
        
        final response = await client.get(
          uri,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ).timeout(const Duration(seconds: 30));

        print('🌐 MyFeedService: Response status: ${response.statusCode}');
        print('🌐 MyFeedService: Response body: ${response.body}');

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final model = MyFeedModel.fromJson(jsonData);
          print('🌐 MyFeedService: My feed parsed successfully: ${model.results?.length ?? 0} items');
          return model;
        } else {
          throw Exception('Failed to load feed: ${response.statusCode} - ${response.body}');
        }
      } catch (e) {
        retryCount++;
        print('❌ MyFeedService: My feed error (attempt $retryCount): $e');
        
        if (retryCount >= maxRetries) {
          throw Exception(NetworkUtils.getNetworkErrorMessage(e));
        } else {
          print('🔄 MyFeedService: Retrying my feed request in 2 seconds...');
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    }
    throw Exception('Failed to load my feed after $maxRetries attempts');
  }

  void dispose() {
    client.close();
  }
}


