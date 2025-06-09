import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mservices/modules/auth/splash/controller/splash_controller.dart';
import 'package:mservices/utils/app_strings.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/app_text.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: Center(
        child: Column(
          spacing: 20.h,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconAsset.appLogo,
              height: 56.h,
              colorFilter: ColorFilter.mode(
                Palette.white,
                BlendMode.srcIn,
              ),
            ),
            AppText(
              text: AppStrings.appName,
              fontFamily: FontFamily.squada,
              color: Palette.white,
              fontSize: 38.sp,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
