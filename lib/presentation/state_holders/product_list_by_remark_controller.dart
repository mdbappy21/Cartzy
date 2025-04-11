import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/product_list_model.dart';
import 'package:cartzy/data/models/product_model.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class ProductListByRemarkController extends GetxController {
  bool _popularProductInProgress = false;
  bool _newProductInProgress = false;
  bool _specialProductInProgress = false;

  bool get popularProductInProgress => _popularProductInProgress;

  bool get newProductInProgress => _newProductInProgress;

  bool get specialProductInProgress => _specialProductInProgress;

  List<ProductModel> _popularProductList = [];
  List<ProductModel> _newProductList = [];
  List<ProductModel> _specialProductList = [];

  List<ProductModel> get popularProductList => _popularProductList;

  List<ProductModel> get newProductList => _newProductList;

  List<ProductModel> get specialProductList => _specialProductList;
  String? _popularErrorMassage;
  String? _newErrorMassage;
  String? _specialErrorMassage;

  String? get popularErrorMassage => _popularErrorMassage;

  String? get newErrorMassage => _newErrorMassage;

  String? get specialErrorMassage => _specialErrorMassage;

  Future<bool> getProductByRemark(String remark) async {
    bool isSuccess = false;
    if (remark == 'popular') {
      _popularProductInProgress = true;
    } else if (remark == 'new') {
      _newProductInProgress = true;
    } else {
      _specialProductInProgress = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productListByRemark(remark),
    );
    if (response.isSuccess) {
      if (remark == 'popular') {
        _popularErrorMassage=null;
        _popularProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      } else if (remark == 'new') {
        _newErrorMassage=null;
        _newProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      } else {
        _specialErrorMassage=null;
        _specialProductList =
            ProductListModel.fromJson(response.responseData).productList ?? [];
      }
      isSuccess = true;
    } else {
      if (remark == 'popular') {
        _popularErrorMassage = response.errorMassage;
      } else if (remark == 'new'){
        _newErrorMassage = response.errorMassage;
      } else {
        _specialErrorMassage = response.errorMassage;
      }
    }
    if (remark == 'popular') {
      _popularProductInProgress = false;
    } else if (remark == 'new') {
      _newProductInProgress = false;
    } else {
      _specialProductInProgress = false;
    }
    update();
    return isSuccess;
  }
}
