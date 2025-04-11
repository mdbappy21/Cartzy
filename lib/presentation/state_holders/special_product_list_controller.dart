import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/product_list_model.dart';
import 'package:cartzy/data/models/product_model.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class SpecialProductListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  List<ProductModel> _productList = [];

  List<ProductModel> get productList => _productList;

  String? _errorMassage;

  String? get errorMassage => _errorMassage;

  Future<bool> getSpecialProductList() async {
    bool isSuccess = false;
    _inProgress=true;

    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListByRemark('special'),
    );
    if (response.isSuccess) {
      _productList = ProductListModel.fromJson(response.responseData).productList ?? [];
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
