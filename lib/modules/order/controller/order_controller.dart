import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/model/order.dart';
import 'package:mservices/modules/auth/login/model/user.dart';
import 'package:mservices/utils/app_preference.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/widgets/app_snackbar.dart';

class OrderController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => onInitData(),
    );
  }

  final Rxn<UserModel> user = Rxn();

  final RxBool isLoading = false.obs;

  final RxList<OrderModel> orders = <OrderModel>[].obs;

  /// ON INIT DATA
  Future<void> onInitData() async {
    if (isLoading.isTrue) return;

    isLoading.value = true;
    orders.clear();

    try {
      final rawJson = await rootBundle.loadString('assets/json/orders_data.json');
      final List<dynamic> jsonList = json.decode(rawJson);

      final items = jsonList.map((e) => OrderModel.fromJson(e)).toList();

      orders.addAll(items);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      AppSnackBar.showSnackBar(message: "Something went wrong!");
    } finally {
      isLoading.value = false;
    }
  }

  /// ON FETCH USER DATA
  void onFetchUserData() {
    String userData = AppPreference.getString(PrefKey.user);

    user.value = UserModel.fromJson(jsonDecode(userData));
  }
}
