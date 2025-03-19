import 'package:cartzy/presentation/ui/screens/splash_screen.dart';
import 'package:cartzy/presentation/ui/utills/app_colors.dart';
import 'package:flutter/material.dart';

class Cartzy extends StatelessWidget {
  const Cartzy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      
      theme: ThemeData(
        colorSchemeSeed: AppColors.themeColor,
        scaffoldBackgroundColor: Colors.white,
        progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.themeColor)
      ),
    );
  }
}
