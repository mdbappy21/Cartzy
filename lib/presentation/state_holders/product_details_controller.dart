import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/product_details_model.dart';
import 'package:cartzy/data/models/product_list_model.dart';
import 'package:cartzy/data/models/product_model.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  ProductDetailsModel? _productModel ;

  ProductDetailsModel? get product => _productModel;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress=true;

    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productDetailsById(productId),
    );
    if (response.isSuccess) {
      _productModel =ProductDetailsModel.fromJson(response.responseData['data'][0]) ;
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
