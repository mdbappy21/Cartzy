import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/product_list_model.dart';
import 'package:cartzy/data/models/product_model.dart';
import 'package:cartzy/data/models/profile_model.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/presentation/state_holders/profile_info_cache_controller.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  bool _inProgress = false;
  bool _isProfileCompleted = false;

  bool get inProgress => _inProgress;
  bool get isProfileCompleted => _isProfileCompleted;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> getProfileDetails(String token) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.readProfile,
      token: token,
    );

    if (response.isSuccess) {
      if (response.responseData['data'] != null) {
        _isProfileCompleted = true;

        // Save profile in cache if data is available
        ProfileModel profile = ProfileModel.fromJson(response.responseData['data']);
        await ProfileInfoCacheController.updateProfile(profileModel: profile);  // Save to local storage

        isSuccess = true;
        _errorMassage = null;
      }
    } else {
      _errorMassage = response.errorMassage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

}
