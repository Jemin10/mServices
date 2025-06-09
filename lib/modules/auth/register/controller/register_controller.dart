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

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final RxBool isLoading = false.obs;
  final Rx<UserType> userType = UserType.customer.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidateMode = AutovalidateMode.disabled.obs;

  /// ON CHANGE USER TYPE
  void onChangeType(UserType? value) {
    if (value != null) {
      userType.value = value;
    }
  }

  /// SET AUTO VALIDATE MODE
  void setAutoValidateMode(AutovalidateMode mode) => autoValidateMode.value = mode;

  /// ON REGISTER
  Future<void> onRegisterTap() async {
    if (isLoading.isTrue) return;

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      try {
        isLoading.value = true;

        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.value.text.trim(),
          password: passController.value.text.trim(),
        )
            .then(
          (value) async {
            try {
              final UserModel user = UserModel(
                uid: FirebaseAuth.instance.currentUser?.uid,
                name: nameController.value.text.trim(),
                email: emailController.value.text.trim(),
                userType: userType.value.name,
              );

              await FirebaseCollections.users.doc(FirebaseAuth.instance.currentUser?.uid).set(user.toJson());

              DocumentSnapshot documentSnapshot =
                  await FirebaseCollections.users.doc(FirebaseAuth.instance.currentUser?.uid).get();

              if (documentSnapshot.exists) {
                UserModel userModel = UserModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

                if (userType.value == UserType.customer) {
                  AppPreference.setBoolean(PrefKey.isLogin, true);
                  AppPreference.setString(PrefKey.userType, UserType.customer.name);
                  AppPreference.setString(PrefKey.user, jsonEncode(userModel));

                  Navigation.replaceAll(Routes.customerDashboard);
                } else {
                  Navigation.pushNamed(
                    Routes.providerForm,
                    arg: {"user": userModel},
                  );
                }

                isLoading.value = false;
              }

              isLoading.value = false;
            } catch (e) {
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
