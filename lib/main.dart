import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/presentation/home_screen/view/home_screen.dart';
import 'package:noviindus/presentation/login_screen/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noviindus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          background: ColorConstants.background,
          primary: ColorConstants.primary,
          surface: ColorConstants.surface,
          onPrimary: ColorConstants.onPrimary,
        ),
        scaffoldBackgroundColor: ColorConstants.background,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
 
