import 'package:get/get.dart';

class ProviderDashboardController extends GetxController {
  RxInt selected = 0.obs;

  /// ON SELECT INDEX
  void onSelectIndex(int value) => selected.value = value;
}
