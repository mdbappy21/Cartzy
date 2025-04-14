import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/state_holders/auth_controler.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;

  bool get inProgress => _inProgress;

  String? get errorMassage => _errorMassage;
  String _accessToken='';
  String get accessToken=>_accessToken;

  Future<bool> verifyOtp(String email,String otp) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.verifyOtp(email,otp),
    );

    if (response.isSuccess && response.responseData['msg'] == 'success') {
      _errorMassage = null;
      _accessToken=response.responseData['data'];
      await Get.find<AuthController>().saveAccessToken(_accessToken);
      isSuccess = true;
    } else {
      _errorMassage = response.errorMassage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
