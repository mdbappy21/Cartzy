import 'package:cartzy/presentation/ui/screens/home_screen.dart';
import 'package:cartzy/presentation/ui/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(height: 24),
              AppLogoWidget(),
              const SizedBox(height: 16),
              Text(
                'Complete Profile',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Get Started with us by providing your information',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 16),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  labelText: 'First Name',
                ),
              ),  const SizedBox(height: 16),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  labelText: 'Last Name'
                ),
              ),  const SizedBox(height: 16),
              TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Mobile No',
                  labelText: 'Mobile No'
                ),
              ),  const SizedBox(height: 16),
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'City',
                  labelText: 'City'
                ),
              ),  const SizedBox(height: 16),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Shipping Address',
                  labelText: 'Shipping Address',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed:_onTapCompleteButton, child: Text('Complete'))
            ],
          ),
        ),
      ),
    );
  }
  void _onTapCompleteButton(){
    Get.to(()=>HomeScreen());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
