import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noviindus/core/config/app_config.dart';

class AuthService {
  final String baseUrl;
  AuthService({this.baseUrl = AppConfig.baseUrl});

  Future<String> login({required String countryCode, required String phone}) async {
    try {
      final uri = Uri.parse('$baseUrl${AppConfig.loginEndpoint}');
      print('Login URL: $uri'); // Debug print
      
      final request = http.MultipartRequest('POST', uri)
        ..fields['country_code'] = countryCode
        ..fields['phone'] = phone;

      print('Sending login request with country_code: $countryCode, phone: $phone'); // Debug print
      
      final response = await http.Response.fromStream(await request.send());
      print('Response status: ${response.statusCode}'); // Debug print
      print('Response body: ${response.body}'); // Debug print
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data['status'] == true && data['token'] != null && data['token']['access'] != null) {
          return data['token']['access'] as String;
        }
        throw Exception('Invalid response: ${response.body}');
      } else {
        throw Exception('Login failed (${response.statusCode}): ${response.body}');
      }
    } catch (e) {
      print('AuthService error: $e'); // Debug print
      rethrow;
    }
  }
}




