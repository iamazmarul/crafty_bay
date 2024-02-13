import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class BrandProductListController extends GetxController {
  bool _getBrandProductsListInProgress = false;
  ProductModel _productModel = ProductModel();
  String _message = '';

  ProductModel get productModel => _productModel;

  bool get getBrandProductsListInProgress =>
      _getBrandProductsListInProgress;

  String get message => _message;

  Future<bool> getProductsByBrand(int brandId) async {
    _getBrandProductsListInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller()
        .getRequest(Urls.getProductListByBrand(brandId));
    _getBrandProductsListInProgress = false;
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.responseJson ?? {});
      update();
      return true;
    } else {
      _message = 'Product brand list data fetch failed!';
      update();
      return false;
    }
  }
}
