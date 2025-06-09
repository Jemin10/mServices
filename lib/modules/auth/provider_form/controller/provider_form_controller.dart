import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/model/user.dart';
import 'package:mservices/utils/app_preference.dart';
import 'package:mservices/utils/app_strings.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/navigation/routes.dart';
import 'package:mservices/widgets/app_snackbar.dart';

class ProviderFormController extends GetxController {
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

  final Rx<UserModel> user = UserModel().obs;

  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  final Rx<String?> selectedServiceType = Rxn();

  final RxBool isLoading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;

  /// SET AUTO VALIDATE MODE
  void setAutoValidateMode(AutovalidateMode mode) => autoValidateMode.value = mode;

  /// ON SELECT SERVICE
  void onSelectService(String? value) {
    if (value != null) {
      selectedServiceType.value = value;
    }
  }

  /// ON LOGIN
  Future<void> onSaveTap() async {
    if (isLoading.isTrue) return;

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      isLoading.value = true;

      try {
        await FirebaseCollections.users.doc(user.value.uid).update({
          "description": descController.text.trim(),
          "experience": experienceController.text.trim(),
          "hourly_rate": priceController.text.trim(),
          "phone_no": phoneNoController.text.trim(),
          "service_type": selectedServiceType.value,
        }).then(
          (value) async {
            DocumentSnapshot documentSnapshot =
                await FirebaseCollections.users.doc(FirebaseAuth.instance.currentUser?.uid).get();

            if (documentSnapshot.exists) {
              UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

              AppPreference.setBoolean(PrefKey.isLogin, true);
              AppPreference.setString(PrefKey.userType, UserType.provider.name);
              AppPreference.setString(PrefKey.user, jsonEncode(userModel));

              Navigation.replaceAll(Routes.providerDashboard);
            }
          },
        );
      } catch (e) {
        AppSnackBar.showSnackBar(message: AuthErrors.commonErrorMsg);
        isLoading.value = false;
      } finally {
        isLoading.value = false;
      }
    } else {
      setAutoValidateMode(AutovalidateMode.always);
    }
  }
}
