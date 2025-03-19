import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              SvgPicture.asset('assets/images/logo.svg', width: 100),
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
