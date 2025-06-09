import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/custom_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = "",
    this.automaticallyImplyLeading,
    this.actions,
    this.closeButton = false,
    this.centerTitle = true,
    this.backArrow = true,
    this.appBarSize,
    this.fontSize,
    this.bottomSize = 0,
    this.bottom,
    this.leading,
    this.color,
    this.onBackTap,
    this.leadingWidth,
    this.titleSpacing,
    this.titleWidget,
  });

  final String title;
  final bool? automaticallyImplyLeading;
  final bool centerTitle;
  final bool backArrow;
  final bool closeButton;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double? appBarSize;
  final double? leadingWidth;
  final double? titleSpacing;
  final double? fontSize;
  final double bottomSize;
  final Widget? leading;
  final Widget? titleWidget;
  final Color? color;
  final void Function()? onBackTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      leading: backArrow && leading == null
          ? Container(
              width: 61.w,
              alignment: Alignment.centerRight,
              child: BackArrowButton(onTap: onBackTap),
            )
          : leading,
      leadingWidth: leadingWidth ?? 61.w,
      elevation: 0,
      backgroundColor: color ?? Colors.transparent,
      title: titleWidget ??
          (title.isNotEmpty
              ? AppText(
                  text: title,
                  fontSize: fontSize ?? 20.sp,
                  fontWeight: FontWeight.w700,
                )
              : const SizedBox()),
      centerTitle: centerTitle,
      actions: actions,
      titleSpacing: titleSpacing ?? 16.w,
      bottom: bottom,
      toolbarHeight: 60.h,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight((appBarSize ?? 60.h) + bottomSize);
}
