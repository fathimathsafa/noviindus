import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;
  AuthService({this.baseUrl = 'https://frijo.noviindus.in'});

  Future<String> login({required String countryCode, required String phone}) async {
    final uri = Uri.parse('$baseUrl/api/otp_verified');
    final request = http.MultipartRequest('POST', uri)
      ..fields['country_code'] = countryCode
      ..fields['phone'] = phone;

    final response = await http.Response.fromStream(await request.send());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['status'] == true && data['token'] != null && data['token']['access'] != null) {
        return data['token']['access'] as String;
      }
      throw Exception('Invalid response');
    } else {
      throw Exception('Login failed (${response.statusCode})');
    }
  }
}

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class AuthService {
//   final String baseUrl;
//   AuthService({this.baseUrl = 'https://frijo.noviindus.in'});

//   Future<String> login({required String countryCode, required String phone}) async {
//     final uri = Uri.parse('$baseUrl/api/otp_verified');
//     final request = http.MultipartRequest('POST', uri)
//       ..fields['country_code'] = countryCode
//       ..fields['phone'] = phone;

//     final response = await http.Response.fromStream(await request.send());
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       final data = jsonDecode(response.body) as Map<String, dynamic>;
//       if (data['status'] == true && data['token'] != null && data['token']['access'] != null) {
//         return data['token']['access'] as String;
//       }
//       throw Exception('Invalid response');
//     } else {
//       throw Exception('Login failed (${response.statusCode})');
//     }
//   }
// }


