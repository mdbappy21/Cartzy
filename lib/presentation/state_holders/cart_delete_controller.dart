import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class CartDeleteController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> deleteACart({required String productId}) async {
    _inProgress = true;
    bool success;
    update();
    final String? accessToken = await AuthController.accessToken;
    if (accessToken != null) {
      NetworkResponse networkResponse =
          await Get.find<NetworkCaller>().getRequest(
              url: Urls.deleteCart(productId: productId),
              token: accessToken);
      if (networkResponse.isSuccess &&
          networkResponse.responseData["msg"].toString() == "success") {
        _inProgress = false;
        success = true;
      } else {
        _inProgress = false;
        success = false;
      }
    } else {
      _inProgress = false;
      success = false;
    }
    update();
    return success;
  }
}
