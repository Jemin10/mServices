import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mservices/utils/app_preference.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/navigation/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Future.delayed(
          const Duration(seconds: 3),
          () => redirectToNext(),
        );
      },
    );
  }

  /// REDIRECT TO NEXT
  void redirectToNext() {
    bool isLogIn = AppPreference.getBoolean(PrefKey.isLogin);

    if (isLogIn) {
      String userType = AppPreference.getString(PrefKey.userType);

      Navigation.replaceAll(
        userType == UserType.provider.name ? Routes.providerDashboard : Routes.customerDashboard,
      );
    } else {
      Navigation.replaceAll(Routes.login);
    }
  }
}
