import 'package:cartzy/data/models/network_response.dart';
import 'package:cartzy/data/models/slider_list_model.dart';
import 'package:cartzy/data/models/slider_model.dart';
import 'package:cartzy/data/services/network_caller.dart';
import 'package:cartzy/data/utills/urls.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;
  String? _errorMassage;
  List<SliderModel> _sliderList = [];

  String? get errorMassage => _errorMassage;

  List<SliderModel> get sliders => _sliderList;
  bool get inProgress=>_inProgress;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.sliderListUrl,
    );
    if (response.isSuccess) {
      isSuccess = true;
      _errorMassage = null;
      _sliderList = SliderListModel.fromJson(response.responseData).data ?? [];
    } else {
      _errorMassage = response.errorMassage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
