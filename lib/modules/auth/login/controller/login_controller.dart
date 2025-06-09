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

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final RxBool isLoading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;

  /// SET AUTO VALIDATE MODE
  void setAutoValidateMode(AutovalidateMode mode) => autoValidateMode.value = mode;

  /// ON LOGIN
  Future<void> onLoginTap() async {
    if (isLoading.isTrue) return;

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      try {
        isLoading.value = true;

        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passController.value.text.trim(),
        )
            .then(
          (value) async {
            DocumentSnapshot documentSnapshot =
                await FirebaseCollections.users.doc(FirebaseAuth.instance.currentUser?.uid).get();

            if (documentSnapshot.exists) {
              UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

              if (userModel.userType == UserType.customer.name) {
                AppPreference.setBoolean(PrefKey.isLogin, true);
                AppPreference.setString(PrefKey.userType, UserType.customer.name);
                AppPreference.setString(PrefKey.user, jsonEncode(userModel));

                Navigation.replaceAll(Routes.customerDashboard);
              } else {
                if (userModel.hourlyRate == null || (userModel.hourlyRate?.isEmpty ?? false)) {
                  Navigation.pushNamed(
                    Routes.providerForm,
                    arg: {"user": userModel},
                  );
                } else {
                  AppPreference.setBoolean(PrefKey.isLogin, true);
                  AppPreference.setString(PrefKey.userType, UserType.provider.name);
                  AppPreference.setString(PrefKey.user, jsonEncode(userModel));

                  Navigation.replaceAll(Routes.providerDashboard);
                }
              }
            } else {
              isLoading.value = false;

              AppSnackBar.showSnackBar(message: AuthErrors.commonErrorMsg);
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;

        AppSnackBar.showSnackBar(message: FirebaseAuthErrors.getErrorMessage(e.code));
      } finally {
        isLoading.value = false;
      }
    } else {
      setAutoValidateMode(AutovalidateMode.always);
    }
  }
}
