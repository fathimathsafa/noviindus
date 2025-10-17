import 'package:flutter/material.dart';
import 'package:noviindus/data/repositories/auth_service.dart';
import 'package:noviindus/presentation/home_screen/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController phoneController = TextEditingController();
  
  bool isLoading = false;
  String? errorMessage;
  String? accessToken;
  final String countryCode = '+91';

  AuthProvider() {
    _loadToken();
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    // Clean and validate phone number
    final phone = phoneController.text.trim().replaceAll(RegExp(r'[^\d]'), '');
    if (phone.isEmpty) {
      errorMessage = 'Please enter a phone number';
      notifyListeners();
      return;
    }
    
    if (phone.length != 10) {
      errorMessage = 'Please enter a valid 10-digit phone number';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final token = await _authService.login(
        countryCode: countryCode,
        phone: phone,
      );
      
      print('Login successful, token received'); 
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      
      accessToken = token;
      
      
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
      }
    } catch (e) {
      print('Login error: $e'); // Debug print
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    accessToken = null;
    phoneController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
