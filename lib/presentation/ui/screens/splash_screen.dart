import 'package:cartzy/presentation/state_holders/auth_controler.dart';
import 'package:cartzy/presentation/ui/screens/email_verification_screen.dart';
import 'package:cartzy/presentation/ui/screens/home_screen.dart';
import 'package:cartzy/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:cartzy/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<void>_moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 3));
    await Get.find<AuthController>().getAccessToken();
    Get.off(() => MainBottomNavScreen());
  }

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("version 1.0.0",style: TextStyle(
                fontSize: 14,
                color: Colors.grey
              ),)
            ],
          ),
        ),
      ),
    );
  }
}