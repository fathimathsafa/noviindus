import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
  
  static Future<bool> canReachServer(String baseUrl) async {
    try {
      final uri = Uri.parse(baseUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 10));
      return response.statusCode < 500; // Server is reachable if not 5xx error
    } catch (e) {
      return false;
    }
  }
  
  static String getNetworkErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network settings.';
    } else if (error.toString().contains('Failed host lookup')) {
      return 'Cannot reach server. Please check your internet connection.';
    } else if (error.toString().contains('timeout')) {
      return 'Request timed out. Please try again.';
    } else {
      return 'Network error. Please try again.';
    }
  }
}
