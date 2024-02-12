import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crafty_bay/application/state_holder_binder.dart';
import 'package:crafty_bay/application/utility/app_colors.dart';
import 'package:crafty_bay/presentation/state_holders/theme_manager_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const CraftyBay({Key? key}) : super(key: key);

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  late final StreamSubscription _connectivityStatusStream;
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    checkInitialInternetConnection();
    checkInternetConnectivityStatus();
    ThemeManager.getThemeMode().then((themeMode) {
      if (themeMode == ThemeMode.system) {
        ThemeManager.setThemeMode(ThemeMode.light);
      }
      _themeMode = themeMode;
    });
    super.initState();
  }

  void checkInitialInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    handleConnectivityStates(result);
  }

  void checkInternetConnectivityStatus() {
    _connectivityStatusStream =
        Connectivity().onConnectivityChanged.listen((status) {
      handleConnectivityStates(status);
    });
  }

  void handleConnectivityStates(ConnectivityResult status) {
    if (status != ConnectivityResult.mobile &&
        status != ConnectivityResult.wifi) {
      Get.defaultDialog(
        title: "No Internet",
        middleText: "Please check your internet connection.",
        barrierDismissible: false,
        titleStyle: const TextStyle(color: Colors.red),
      );
    } else {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: CraftyBay.globalKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: StateHolderBinder(),
      themeMode: _themeMode,
      theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF07ADAE),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              foregroundColor: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
          )),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF07ADAE),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF07ADAE),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF07ADAE),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              backgroundColor: Colors.white,
              elevation: 5)),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF07ADAE),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              foregroundColor: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              )),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF07ADAE),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF07ADAE),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF07ADAE),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
          ),
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
              backgroundColor: Colors.white,
              elevation: 5)),
    );
  }

  @override
  void dispose() {
    _connectivityStatusStream.cancel();
    super.dispose();
  }
}
