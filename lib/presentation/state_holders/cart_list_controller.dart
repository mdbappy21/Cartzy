import 'package:cartzy/data/models/cart_list.dart';
import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

import 'package:cartzy/data/models/cart.dart';

class CartListController extends GetxController {
  bool _loading = false;
  List<Cart> _carts = [];
  int _totalPrice = 0;
  int get totalPrice => _totalPrice;

  bool get loading => _loading;

  List<Cart> get carts => _carts;

  Future<bool> getCarts() async {
    _loading = true;
    bool success;
    update();
    final String? accessToken =  await AuthController.accessToken;
    if (accessToken!=null) {
      NetworkResponse networkResponse =
          await Get.find<NetworkCaller>().getRequest(url:Urls.fetchCarts, token: accessToken);
      if(networkResponse.isSuccess){
        _loading = false;
        _carts = CartList.fromJson(networkResponse.responseData).data??[];
        _totalPrice = 0;
        for (Cart cart in _carts) {
          _totalPrice += int.parse(cart.price ?? '0');
        }
        success = true;
      }else{
        _loading = false;
        success = false;
      }
    }else{
      _loading = false;
      success =false;
    }
    update();
    return success;
  }
}
