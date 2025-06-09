import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/model/user.dart';
import 'package:mservices/utils/app_preference.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/navigation/routes.dart';

class ProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => onFetchUserData(),
    );
  }

  final Rxn<UserModel> user = Rxn();

  /// ON FETCH USER DATA
  void onFetchUserData() {
    String userData = AppPreference.getString(PrefKey.user);

    user.value = UserModel.fromJson(jsonDecode(userData));
  }

  /// ON EDIT PROFILE TAP
  Future<void> onEditProfileTap() async {
    final result = await Navigation.pushNamed(
      Routes.editProfile,
      arg: {"user": user.value},
    );

    if (result != null && result["success"] == true) {
      onFetchUserData();
    }
  }

  /// ON LOGOUT TAP
  Future<void> onLogoutTap() async {
    AppPreference.clearSharedPreferences();
    Navigation.replaceAll(Routes.login);
  }
}
