import 'package:flutter/material.dart';
import 'package:noviindus/data/repositories/auth_service.dart';
import 'package:noviindus/presentation/home_screen/view/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends ChangeNotifier {
  LoginScreenController({AuthService? service}) : _service = service ?? AuthService();

  final AuthService _service;
  final TextEditingController phoneController = TextEditingController();
  String countryCode = '+91';
  bool isLoading = false;
  String? errorMessage;

  Future<void> onContinue(BuildContext context) async {
    final String phone = phoneController.text.trim();
    if (phone.isEmpty) {
      errorMessage = 'Please enter phone number';
      notifyListeners();
      return;
    }
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final token = await _service.login(countryCode: countryCode, phone: phone);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

class LoginScreenControllerProvider extends InheritedNotifier<LoginScreenController> {
  const LoginScreenControllerProvider({
    super.key,
    required LoginScreenController controller,
    required Widget child,
  }) : super(notifier: controller, child: child);

  static LoginScreenController of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<LoginScreenControllerProvider>();
    assert(provider != null, 'LoginScreenControllerProvider not found in context');
    return provider!.notifier!;
  }

  @override
  bool updateShouldNotify(covariant InheritedNotifier<LoginScreenController> oldWidget) => true;
}


