import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/profile/controller/profile_controller.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppBar(
          backArrow: false,
          title: "${_controller.user.value?.userType?.capitalizeFirst}\tProfile",
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 100.h,
                  width: 100.h,
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                    color: Palette.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: AppText(
                      text: _controller.user.value?.name?[0].capitalizeFirst ?? "",
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w900,
                      color: Palette.secondary,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: AppText(
                  text: _controller.user.value?.name ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
              AppText(
                text: _controller.user.value?.email ?? "",
                textAlign: TextAlign.center,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Palette.greyText,
              ),
              50.h.verticalSpace,
              GestureDetector(
                onTap: _controller.onEditProfileTap,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    spacing: 16.w,
                    children: [
                      SvgPicture.asset(
                        IconAsset.edit,
                        height: 20.h,
                      ),
                      Expanded(
                        child: AppText(
                          text: "Edit Profile",
                          color: Palette.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          IconAsset.backArrow,
                          height: 16.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: Palette.lightGrey,
              ),
              GestureDetector(
                onTap: _controller.onLogoutTap,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    spacing: 16.w,
                    children: [
                      SvgPicture.asset(
                        IconAsset.logout,
                        height: 20.h,
                      ),
                      Expanded(
                        child: AppText(
                          text: "Logout",
                          color: Palette.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
