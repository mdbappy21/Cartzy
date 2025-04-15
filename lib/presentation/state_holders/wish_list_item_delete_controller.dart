import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class WishListItemDeleteController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<bool> delete({required String productId}) async {
    _inProgress =true;
    update();
    late bool success;
    String? token = AuthController.accessToken;
    if(token!=null){
      NetworkResponse networkResponse = await Get.find<NetworkCaller>().getRequest(
          url: Urls.deleteFromWishList(productId: productId), token: token);
      if(networkResponse.isSuccess&&networkResponse.responseData["msg"].toString() == "success"){
        _inProgress = false;
        success = true;
      }else{
        _inProgress = false;
        success = false;
      }
    } else{
      _inProgress = false;
      success =false;
    }

    update();
    return success;
  }
}
