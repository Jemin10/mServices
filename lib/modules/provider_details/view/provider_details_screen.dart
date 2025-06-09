import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/provider_details/controller/provider_details_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/utils.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/appbar.dart';
import 'package:mservices/widgets/custom_button.dart';

class ProviderDetailsScreen extends StatelessWidget {
  ProviderDetailsScreen({super.key});

  final ProviderDetailsController _controller = Get.put(ProviderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          title: "${_controller.user.value?.name?.split(" ").first ?? ""}'s Profile",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: 70.h,
                decoration: BoxDecoration(
                  color: Palette.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: AppText(
                    text: _controller.user.value?.name?.capitalizeFirst?[0] ?? "",
                    fontWeight: FontWeight.w900,
                    color: Palette.secondary,
                    fontSize: 30.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.h, bottom: 6.h),
                child: AppText(
                  text: _controller.user.value?.name ?? "",
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppText(
                text: _controller.user.value?.serviceType ?? "",
                color: Palette.greyText,
                fontSize: 14.sp,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppText(
                    text: _controller.user.value?.description ?? "",
                    fontSize: 14.sp,
                  ),
                ),
              ),
              Row(
                spacing: 10.w,
                children: [
                  SvgPicture.asset(
                    IconAsset.price,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${_controller.user.value?.hourlyRate}₹",
                          style: TextStyle(
                            color: Palette.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: "\tper hour",
                        ),
                      ],
                      style: TextStyle(
                        fontFamily: FontFamily.inter,
                        color: Palette.text,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        height: 1.1,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ],
              ),
              8.h.verticalSpace,
              Row(
                spacing: 10.w,
                children: [
                  SvgPicture.asset(
                    IconAsset.award,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(Palette.primary, BlendMode.srcIn),
                  ),
                  _controller.user.value?.experience != "0"
                      ? RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${_controller.user.value?.experience}",
                                style: TextStyle(
                                  color: Palette.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: "\tyears of Experience",
                              ),
                            ],
                            style: TextStyle(
                              fontFamily: FontFamily.inter,
                              color: Palette.text,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              height: 1.1,
                              letterSpacing: 0,
                            ),
                          ),
                        )
                      : AppText(
                          text: "Beginner",
                          fontSize: 12.sp,
                        ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: CustomButton(
              onTap: () => Utils.launchDialer(_controller.user.value?.phoneNo ?? ""),
              svg: IconAsset.call,
              text: "Call Now",
              height: 55.h,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
