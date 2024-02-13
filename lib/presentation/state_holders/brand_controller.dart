import 'package:crafty_bay/data/models/brand_model.dart';
import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  bool _getBrandInProgress = false;
  BrandModel _brandModel = BrandModel();
  String _message = '';

  BrandModel get brandModel => _brandModel;

  bool get getBrandInProgress => _getBrandInProgress;

  String get message => _message;

  Future<bool> getBrand() async {
    _getBrandInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.getBrands);
    _getBrandInProgress = false;
    if (response.isSuccess) {
      _brandModel = BrandModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'Brand list data fetch failed!';
      update();
      return false;
    }
  }
}
