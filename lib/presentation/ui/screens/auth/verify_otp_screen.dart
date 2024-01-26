import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  int _timerSeconds = 120;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void resendCode() {
    setState(() {
      _timerSeconds = 120;
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(
                height: 140,
              ),
              const AppLogo(
                height: 90,
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Enter OTP Code",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "A 4 digit OTP code has been sent",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: 16,
              ),
              PinCodeTextField(
                length: 4,
                obscureText: false,
                animationType: AnimationType.fade,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.transparent,
                    inactiveFillColor: Colors.transparent,
                    inactiveColor: AppColors.primaryColor,
                    selectedFillColor: Colors.transparent,
                    selectedColor: Colors.purple),
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                onCompleted: (v) {},
                appContext: context,
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(const CompleteProfileScreen());
                  },
                  child: const Text("Next"),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "This code will expire ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: '$_timerSeconds s',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: _timerSeconds > 0 ? null : resendCode,
                child: Text(
                  "Resend Code",
                  style: TextStyle(
                    color: _timerSeconds > 0
                        ? Colors.grey
                        : AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
