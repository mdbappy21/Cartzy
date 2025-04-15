import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/wished_product.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:cartzy/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';
import 'package:cartzy/data/models//wish_list.dart';

class WishListController extends GetxController {
  bool _loading = false;
  List<WishedProduct> _wishList = [];

  bool get loading => _loading;

  List<WishedProduct> get wishList => _wishList;

  Future<bool> getUserWishes() async {
    _loading = true;
    bool success;
    update();
    final String? accessToken =  AuthController.accessToken;
    if (accessToken!=null) {
      NetworkResponse networkResponse = await Get.find<NetworkCaller>().getRequest(url: Urls.fetchWishList, token: accessToken);
      if(networkResponse.isSuccess){
        _loading = false;
        _wishList = WishList.fromJson(networkResponse.responseData).products??[];
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
