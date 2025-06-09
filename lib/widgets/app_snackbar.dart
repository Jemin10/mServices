import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/app_text.dart';

class AppSnackBar {
  static void showSnackBar({required String message, bool isError = true}) {
    Get.closeAllSnackbars();
    Get.snackbar(
      "",
      "",
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      snackStyle: SnackStyle.FLOATING,
      messageText: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AppText(
              text: message,
              color: isError ? Palette.white : Palette.text,
              fontSize: 13.sp,
            ),
          ),
          5.w.verticalSpace,
          GestureDetector(
            onTap: () => Get.closeCurrentSnackbar(),
            child: Icon(Icons.close, color: isError ? Colors.white : Palette.text, size: 18.sp),
          )
        ],
      ),
      titleText: Container(),
      backgroundColor: isError ? Palette.red : Colors.green,
      animationDuration: const Duration(milliseconds: 400),
      duration: const Duration(seconds: 3),
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 6),
      isDismissible: true,
    );
  }
}
