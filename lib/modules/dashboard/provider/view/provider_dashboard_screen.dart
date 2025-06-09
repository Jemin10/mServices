import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/dashboard/provider/controller/provider_dashboard_controller.dart';
import 'package:mservices/modules/order/view/order_screen.dart';
import 'package:mservices/modules/profile/view/profile_screen.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/bottom_item.dart';

class ProviderDashboardScreen extends StatelessWidget {
  ProviderDashboardScreen({super.key});

  final ProviderDashboardController _controller = Get.put(ProviderDashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _controller.selected.value == 0 ? OrderScreen() : ProfileScreen(),
        bottomNavigationBar: Container(
          height: 70.h,
          color: Palette.secondary,
          child: Row(
            children: [
              BottomItem(
                onTap: () => _controller.onSelectIndex(0),
                icon: IconAsset.home,
                isSelected: _controller.selected.value == 0,
              ),
              BottomItem(
                onTap: () => _controller.onSelectIndex(1),
                icon: IconAsset.user,
                isSelected: _controller.selected.value == 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
