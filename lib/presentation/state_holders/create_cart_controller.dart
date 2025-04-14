import 'package:cartzy/data/models/add_to_cart.dart';
import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class CreateCartController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;

  Future<bool> createCart(AddToCart cart) async {
    _loading = true;
    update();
    final String? accessToken =  await AuthController.accessToken;
    if (accessToken!=null) {
      NetworkResponse networkServerResponse = await Get.find<
          NetworkCaller>().postRequest(
          url: Urls.createCart, body:cart.toJson());
      if(networkServerResponse.isSuccess){
        _loading = false;
        update();
        return true;
      }else{
        _loading = false;
        update();
        return false;
      }
    } else {
      _loading = false;
      update();
      return false;
    }
  }
}