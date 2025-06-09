import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/login/model/user.dart';
import 'package:mservices/utils/app_preference.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/widgets/app_snackbar.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => onInitData(),
    );
  }

  final Rxn<UserModel> user = Rxn();

  final RxBool isLoading = false.obs;

  final TextEditingController searchController = TextEditingController();

  final RxList<UserModel> providers = <UserModel>[].obs;

  final RxString searchText = "".obs;
  final RxString selectedType = "All".obs;

  /// ON INIT DATA
  Future<void> onInitData() async {
    if (isLoading.isTrue) return;

    isLoading.value = true;
    providers.clear();

    selectedType.value = "All";

    try {
      final rawJson = await rootBundle.loadString('assets/json/service_providers.json');
      final List<dynamic> jsonList = json.decode(rawJson);

      final items = jsonList.map((e) => UserModel.fromJson(e)).toList();

      providers.addAll(items);

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

  /// ON CLEAR SEARCH
  void onClearSearch() {
    searchController.clear();
    searchText.value = "";
  }

  /// ON SEARCH
  void onSearch(String query) {
    if (query.trim().isEmpty) {
      onClearSearch();
    } else {
      searchText.value = query.trim();
    }
  }
}
