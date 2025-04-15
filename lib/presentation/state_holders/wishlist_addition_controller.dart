import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class WishlistAdditionController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<bool> addToWishList({required String productId}) async {
    _loading = true;
    bool success;
    update();
    final String? accessToken = AuthController.accessToken;
    if (accessToken != null) {
      NetworkResponse networkServerResponse =
          await Get.find<NetworkCaller>().getRequest(
              url: Urls.addToWishList(productId: productId),
              token: accessToken);
      if (networkServerResponse.isSuccess &&
          networkServerResponse.responseData["msg"].toString() == "success") {
        _loading = false;
        success = true;
      } else {
        _loading = false;
        success = false;
      }
    } else {
      _loading = false;
      success = false;
    }
    update();
    return success;
  }
}
