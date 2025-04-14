import 'package:cartzy/data/models/create_profile_data.dart';
import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';

class CreateProfileController extends GetxController{

  bool _loading = false;
  String? _errorMessage;


  bool get loading => _loading;

  String get errorMessage => _errorMessage ?? '';

  Future<bool> createProfile(CreateProfileData profileData) async {
    bool success;
    _loading = true;
    update();
    String? token = await Get.find<AuthController>().getAccessToken();
    print('Token : $token');
    if(token!=null){
      final NetworkResponse networkResponse =
      await Get.find<NetworkCaller>().postRequest(url: Urls.createProfile,body: profileData.toJson());
      if (networkResponse.isSuccess) {
        success = true;
        _errorMessage = null;
        _loading = false;
        update();
      } else {
        success = false;
        _errorMessage = 'You need to login';
        _loading = false;
        update();
      }
    }else{
      success = false;
      _errorMessage = 'You need to login';
      _loading = false;
      update();
    }

    return success;
  }
}