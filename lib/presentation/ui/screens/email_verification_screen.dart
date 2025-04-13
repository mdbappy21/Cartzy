import 'package:cartzy/presentation/state_holders/email_verification_controller.dart';
import 'package:cartzy/presentation/ui/screens/otp_verification_screen.dart';
import 'package:cartzy/presentation/ui/utils/app_constents.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:cartzy/presentation/ui/widgets/app_logo_widget.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
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
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController=Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email'
                ),
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter your Email';
                  } else if (AppConstants.emailRegExp.hasMatch(value!) ==
                      false) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GetBuilder<EmailVerificationController>(
                builder: (emailVerificationController) {
                  return Visibility(
                    visible: !emailVerificationController.inProgress,
                    replacement: CenteredCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: _onTapNextButton, child: Text('Next'),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapNextButton() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    bool result = await _emailVerificationController.verifyEmail(
        _emailTEController.text.trim());
    if (result) {
      Get.to(() =>
          OTPVerificationScreen(email: _emailTEController.text.trim(),));
    } else {
      if (mounted) {
        showSnackBarMassage(_emailVerificationController.errorMassage!, true);
      }
    }
  }


  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
