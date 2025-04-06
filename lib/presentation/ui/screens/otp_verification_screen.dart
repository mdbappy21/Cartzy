import 'dart:async';
import 'package:cartzy/presentation/ui/screens/complete_profile_screen.dart';
import 'package:cartzy/presentation/ui/utills/app_colors.dart';
import 'package:cartzy/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() =>
      _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  int _remainingSeconds = 60;
  Timer? _timer;
  bool _canResend = false;
  final TextEditingController _otpTEController=TextEditingController();


  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 82),
            AppLogoWidget(),
            const SizedBox(height: 24),
            Text(
              'Enter OTP Code',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'A 6 digit code sent to your email address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            PinCodeTextField(
              length: 6,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                selectedFillColor: Colors.white,
                selectedColor: Colors.green,
                inactiveFillColor: Colors.white,
                inactiveColor: AppColors.themeColor,
              ),
              animationDuration: Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              controller: _otpTEController,
              appContext: context,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _onTapNextButton, child: Text('Next')),
            const SizedBox(height: 16),
            RichText(text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black54
              ),
              text: 'This Code Will expire in ',
              children: [
                TextSpan(text: '${_remainingSeconds}s',style:TextStyle(color: AppColors.themeColor))
              ]
            ),),
            const SizedBox(height: 16),
            _canResend ? TextButton(
              onPressed: onResendPressed,
              child: Text('Resend code'),
            ) : AbsorbPointer(
              absorbing: true,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Resend code', style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startCountdown() {
    setState(() {
      _remainingSeconds = 60;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  void onResendPressed() {
    // Add your resend logic here (API call, OTP send, etc.)
    startCountdown(); // Restart countdown
  }

  void _onTapNextButton(){
    Get.to(()=>CompleteProfileScreen());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpTEController.dispose();
    super.dispose();
  }
}
