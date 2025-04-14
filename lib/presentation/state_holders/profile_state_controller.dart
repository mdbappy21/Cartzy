import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/read_profile_data.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/presentation//state_holders/profile_info_cache_controller.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

import 'package:cartzy/data/models/profile_model.dart';

class ProfileState {
  static Future<bool> checkProfileState() async {
    bool profileExist;
    String? token = await Get.find<AuthController>().getAccessToken();
    if (token != null) {
      NetworkResponse networkServerResponse = await Get.find<NetworkCaller>()
          .getRequest(url: Urls.readProfile, token: token);
      if (networkServerResponse.isSuccess &&
          networkServerResponse.responseData["data"] != null &&
          networkServerResponse.responseData["msg"] == 'success') {
        ProfileInfoCacheController.updateProfile(
          profileModel:
              ReadProfileData.fromJson(
                networkServerResponse.responseData,
              ).data ??
              ProfileModel(),
        );
        profileExist = true;
      } else {
        profileExist = false;
      }
    } else {
      profileExist = false;
    }
    return profileExist;
  }
}
