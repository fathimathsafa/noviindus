import 'dart:async';
import 'package:flutter/material.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/presentation/login_screen/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: const Center(
        child: Text(
          'Noviindus',
          style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}


