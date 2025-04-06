import 'package:cartzy/presentation/ui/screens/otp_verification_screen.dart';
import 'package:cartzy/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEController=TextEditingController();

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
              'Welcome Back',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Please Enter your Email Address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                labelText: 'Email'
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed:_onTapNextButton, child: Text('Next'))
          ],
        ),
      ),
    );
  }

  void _onTapNextButton(){
    Get.to(()=>OTPVerificationScreen());
  }


  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
