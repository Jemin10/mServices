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
import 'package:mservices/widgets/app_snackbar.dart';

class EditProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        var args = Get.arguments;

        if (args != null && args["user"] != null) {
          user.value = args["user"];

          if (user.value != null) {
            nameController.text = user.value?.name ?? "";
            emailController.text = user.value?.email ?? "";

            if (user.value?.userType == UserType.provider.name) {
              phoneController.text = user.value?.phoneNo ?? "";
              experienceController.text = user.value?.experience ?? "";
              descController.text = user.value?.description ?? "";
              priceController.text = user.value?.hourlyRate ?? "";

              selectedServiceType.value = user.value?.serviceType ?? "";
            }
          }
        }
      },
    );
  }

  final Rxn<UserModel> user = Rxn();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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

  /// ON UPDATE
  Future<void> onUpdateTap() async {
    if (isLoading.isTrue) return;

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      isLoading.value = true;

      try {
        await FirebaseCollections.users.doc(user.value?.uid).update({
          "name": nameController.text.trim(),
          "description": descController.text.trim(),
          "experience": experienceController.text.trim(),
          "hourly_rate": priceController.text.trim(),
          "phone_no": phoneController.text.trim(),
          "service_type": selectedServiceType.value,
        }).then(
          (value) async {
            DocumentSnapshot documentSnapshot =
                await FirebaseCollections.users.doc(FirebaseAuth.instance.currentUser?.uid).get();

            if (documentSnapshot.exists) {
              UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

              AppPreference.setString(PrefKey.user, jsonEncode(userModel));

              Navigation.pop(data: {"success": true});
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
