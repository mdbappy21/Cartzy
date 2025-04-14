import 'package:cartzy/data/models/create_profile_data.dart';
import 'package:cartzy/data/models/profile_model.dart';
import 'package:cartzy/presentation/UI/screens/email_verification_screen.dart';
import 'package:cartzy/presentation/state_holders/profile_info_cache_controller.dart';
import 'package:cartzy/presentation/ui/utils/snack_massage.dart';
import 'package:cartzy/presentation/ui/utils/app_constents.dart';
import 'package:cartzy/presentation/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cartzy/presentation/state_holders/create_profile_controller.dart';
import 'package:cartzy/presentation/ui/widgets/app_logo_widget.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({
    super.key,
    required this.heading,
    this.readProfileData,
  });
  final String heading;
  final ProfileModel? readProfileData;
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final TextEditingController _stateTEController = TextEditingController();
  final TextEditingController _countryTEController = TextEditingController();
  final TextEditingController _postCodeTEController = TextEditingController();
  final TextEditingController _faxNumberTEController = TextEditingController();
  final TextEditingController _shippingAddressTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameTEController.text = widget.readProfileData?.cusName?.split(' ')[0] ?? '';
    _lastNameTEController.text = widget.readProfileData?.cusName?.split(' ')[1] ?? '';
    _mobileTEController.text = widget.readProfileData?.cusPhone ?? '';
    _faxNumberTEController.text = widget.readProfileData?.cusFax ?? '';
    _cityTEController.text = widget.readProfileData?.cusCity ?? '';
    _postCodeTEController.text = widget.readProfileData?.cusPostcode ?? '';
    _stateTEController.text = widget.readProfileData?.cusState ?? '';
    _countryTEController.text = widget.readProfileData?.cusCountry ?? '';
    _shippingAddressTEController.text = widget.readProfileData?.shipAdd ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height / 20,
            left: 24,
            right: 24,
            bottom: MediaQuery.sizeOf(context).height / 20,
          ),
          child: _buildProfileInfoForm(context),
        ),
      ),
    );
  }

  Widget _buildProfileInfoForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const AppLogoWidget(),
          const SizedBox(height: 24),
          Text(
            widget.heading,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 4),
          Text('Get started with us with your details',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _firstNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly enter your first name!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'First Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _lastNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly enter your last name!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'Last Name'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _mobileTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly enter your phone number!';
                } else if (AppConstants.numberRegExp.hasMatch(i) == false) {
                  return 'Please enter a valid phone number!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Mobile'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _faxNumberTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly share your fax number!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Fax'),
          ),
          const SizedBox(height: 15),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _cityTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly share your city name!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'City'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _postCodeTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly share your post code!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Post Code'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _stateTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly share your state name!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'State'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _countryTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly share the name of your country!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(hintText: 'Country'),
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: Theme.of(context,).textTheme.bodySmall!.copyWith(color: Colors.black87),
            controller: _shippingAddressTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (String? i) {
              if (i != null) {
                if (i.trim().isEmpty) {
                  return 'Kindly share your shipping address!';
                }
              }
              return null;
            },
            textInputAction: TextInputAction.next,
            maxLines: 3,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: 'Shipping Address',
            ),
          ),
          const SizedBox(height: 16),
          _buildCompletedProfileButton(context),
        ],
      ),
    );
  }

  Widget _buildCompletedProfileButton(BuildContext context) {
    return GetBuilder<CreateProfileController>(
      builder: (createProfileController) {
        return Visibility(
          visible: !createProfileController.loading,
          replacement: const CenteredCircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                CreateProfileData profileData = CreateProfileData(
                  cusName:
                      '${_firstNameTEController.text.trim()} ${_lastNameTEController.text.trim()}',
                  cusPhone: _mobileTEController.text,
                  cusCity: _cityTEController.text,
                  shipAdd: _shippingAddressTEController.text,
                  shipCity: _cityTEController.text,
                  shipCountry: _countryTEController.text,
                  shipName:
                      '${_firstNameTEController.text} ${_lastNameTEController.text}',
                  shipPhone: _mobileTEController.text,
                  shipPostcode: _postCodeTEController.text,
                  shipState: _stateTEController.text,
                  cusAdd: _shippingAddressTEController.text,
                  cusCountry: _countryTEController.text,
                  cusFax: _faxNumberTEController.text,
                  cusPostcode: _postCodeTEController.text,
                  cusState: _stateTEController.text,
                );
                bool created = await createProfileController.createProfile(
                  profileData,
                );
                if (created) {
                  bottomPopUpMessage(context, 'Profile updated!');
                  await ProfileInfoCacheController.updateProfile(
                    profileModel: ProfileModel(
                      cusName:
                          '${_firstNameTEController.text.trim()} ${_lastNameTEController.text.trim()}',
                      cusPhone: _mobileTEController.text,
                      cusCity: _cityTEController.text,
                      shipAdd: _shippingAddressTEController.text,
                      shipCity: _cityTEController.text,
                      shipCountry: _countryTEController.text,
                      shipName:
                          '${_firstNameTEController.text} ${_lastNameTEController.text}',
                      shipPhone: _mobileTEController.text,
                      shipPostcode: _postCodeTEController.text,
                      shipState: _stateTEController.text,
                      cusAdd: _shippingAddressTEController.text,
                      cusCountry: _countryTEController.text,
                      cusFax: _faxNumberTEController.text,
                      cusPostcode: _postCodeTEController.text,
                      cusState: _stateTEController.text,
                    ),
                  );
                  if (widget.heading == 'Update Profile') {
                    Get.back();
                  } else {
                    Get.close(3);
                  }
                } else {
                  bottomPopUpMessage(
                    context,
                    createProfileController.errorMessage,
                    showError: true,
                  );
                  Get.off(() => const EmailVerificationScreen());
                }
              }
            },
            child: Text(
              'Completed',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
