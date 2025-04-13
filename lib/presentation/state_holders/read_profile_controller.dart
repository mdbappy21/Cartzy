import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/product_list_model.dart';
import 'package:cartzy/data/models/product_model.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/state_holders/auth_controler.dart';
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
    _inProgress=true;

    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.readProfile,
      token: token,
    );
    if (response.isSuccess) {
      if(response.responseData['data']!=null){
        _isProfileCompleted=true;
        await Get.find<AuthController>().saveAccessToken(token);
      }
      isSuccess = true;
      _errorMassage=null;
    } else {
        _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
