import 'package:cartzy/data/models/category_list_model.dart';
import 'package:cartzy/data/models/category_model.dart';
import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  List<CategoryModel> _categoryList = [];

  String? get errorMassage => _errorMassage;

  List<CategoryModel> get categoryList => _categoryList;
  bool get inProgress=>_inProgress;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.categoryListUrl,
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMassage = null;
      _categoryList = CategoryListModel.fromJson(response.responseData).categoryList ?? [];
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
