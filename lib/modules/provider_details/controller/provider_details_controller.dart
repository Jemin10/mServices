import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/model/user.dart';

class ProviderDetailsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var args = Get.arguments;

        if (args != null && args["user"] != null) {
          user.value = args["user"];
        }
      },
    );
  }

  final Rxn<UserModel> user = Rxn();
}
