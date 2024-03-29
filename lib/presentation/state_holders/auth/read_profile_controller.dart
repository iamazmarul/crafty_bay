import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/read_profile_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController {
  String _message = '';
  ReadProfileModel _readProfileModel = ReadProfileModel();

  String get message => _message;

  ReadProfileModel get readProfileModel => _readProfileModel;

  Future<bool> readProfileData() async {
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.readProfile, isLogin: true);
    if (response.isSuccess) {
      _readProfileModel =
          ReadProfileModel.fromJson(response.responseJson ?? {});
      return true;
    } else {
      _message = 'Read profile data fetch failed!';
      return false;
    }
  }
}
