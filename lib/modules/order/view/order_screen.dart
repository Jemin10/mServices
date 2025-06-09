import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mservices/modules/order/controller/order_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/enums.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/appbar.dart';
import 'package:mservices/widgets/custom_loading_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _controller.onFetchUserData(),
    );
  }

  final OrderController _controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          backArrow: false,
          leading: Container(
            width: 61.w,
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(
              IconAsset.appLogo,
              width: 45.w,
            ),
          ),
          title: "Hii, ${_controller.user.value?.name?.split(" ").first ?? ""} 👋",
          centerTitle: false,
        ),
        body: _controller.isLoading.isTrue
            ? Center(
                child: CustomLoadingWidget(),
              )
            : _controller.orders.isEmpty
                ? Center(
                    child: AppText(text: "No Data Found !"),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: _controller.orders.length,
                    itemBuilder: (context, index) {
                      final data = _controller.orders[index];

                      return Container(
                        padding: EdgeInsets.all(10.w),
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Palette.lightGrey, width: 2.w),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              spacing: 8.h,
                              children: [
                                Row(
                                  spacing: 10.w,
                                  children: [
                                    Container(
                                      height: 50.h,
                                      width: 50.h,
                                      decoration: BoxDecoration(
                                        color: Palette.primary,
                                        borderRadius: BorderRadius.circular(8.r),
                                      ),
                                      child: Center(
                                        child: AppText(
                                          text: data.customer?.capitalizeFirst?[0] ?? "",
                                          fontWeight: FontWeight.w900,
                                          color: Palette.secondary,
                                          fontSize: 25.sp,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      spacing: 6.h,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: data.customer ?? "",
                                        ),
                                        AppText(
                                          text: data.location ?? "",
                                          fontSize: 14.sp,
                                          color: Palette.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        spacing: 6.w,
                                        children: [
                                          SvgPicture.asset(
                                            IconAsset.calendar,
                                            height: 16.h,
                                            colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                                          ),
                                          AppText(
                                            text: DateFormat("dd/MM/yyyy").format(data.date != null
                                                ? DateTime.parse(data.date!)
                                                : DateTime.now()),
                                            fontSize: 12.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        spacing: 6.w,
                                        children: [
                                          SvgPicture.asset(
                                            IconAsset.clock,
                                            height: 16.h,
                                            colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                                          ),
                                          AppText(
                                            text: "${data.hours ?? ""} hours",
                                            fontSize: 12.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                                decoration: BoxDecoration(
                                  color: (data.status == OrderType.pending.name
                                          ? Palette.yellow
                                          : data.status == OrderType.cancelled.name
                                              ? Palette.red
                                              : Palette.green)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Center(
                                  child: AppText(
                                    text: data.status?.capitalizeFirst ?? "",
                                    color: (data.status == OrderType.pending.name
                                        ? Palette.yellow
                                        : data.status == OrderType.cancelled.name
                                            ? Palette.red
                                            : Palette.green),
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
