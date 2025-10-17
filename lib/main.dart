import 'package:flutter/material.dart';
import 'package:noviindus/data/repositories/home_service.dart';
import 'package:provider/provider.dart';
import 'package:noviindus/core/constant/color_constants.dart';
import 'package:noviindus/presentation/login_screen/provider/auth_provider.dart';
import 'package:noviindus/presentation/home_screen/provider/home_provider.dart';
import 'package:noviindus/presentation/add_video_screen/provider/add_video_provider.dart';
import 'package:noviindus/presentation/my_feed_screen/provider/my_feed_provider.dart';
import 'package:noviindus/presentation/login_screen/view/login_screen.dart';
import 'package:noviindus/presentation/home_screen/view/home_screen.dart';
import 'package:noviindus/presentation/add_video_screen/view/add_video_screen.dart';
import 'package:noviindus/presentation/my_feed_screen/view/my_feed_screen.dart';
import 'package:noviindus/presentation/splash/view/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider(service:HomeService() )),
        ChangeNotifierProvider(create: (_) => AddVideoProvider()),
        ChangeNotifierProvider(create: (_) => MyFeedProvider()),
      ],
      child: MaterialApp(
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
        
        home: const SplashScreen(),
      ),
    );
  }
}
 
