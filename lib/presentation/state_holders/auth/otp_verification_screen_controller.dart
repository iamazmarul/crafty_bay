import 'dart:async';

import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth/auth_controller.dart';
import 'package:get/get.dart';

class OtpVerificationScreenController extends GetxController {
  late int seconds;
  late Timer _timer;

  Timer get timer => _timer;

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      seconds == 0 ? _timer.cancel() : seconds--;
      update();
    });
  }

  bool _otpVerificationInProgress = false;
  String _message = '';

  bool get otpVerificationInProgress => _otpVerificationInProgress;

  String get message => _message;

  Future<bool> verifyOtp(String email, String otp) async {
    _otpVerificationInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller().getRequest(Urls.verifyOtp(email, otp));
    _otpVerificationInProgress = false;
    update();
    if (response.isSuccess) {
      await AuthController.setAccessToken(response.responseJson?['data']);
      return true;
    } else {
      return false;
    }
  }
}
