import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/navigation/navigation.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/widgets/app_text.dart';
import 'package:mservices/widgets/custom_loading_widget.dart';

class CustomButton extends StatefulWidget {
  final double? height;
  final VoidCallback? onTap;
  final double? width;
  final double? fontSize;
  final double? loaderBoxSize;
  final double? loaderStrokeWidth;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final String? text;
  final String? svg;
  final String? endSvg;
  final Color? buttonColor;
  final Color? disableButtonColor;
  final Color? textColor;
  final Color? disableTextColor;
  final Color? borderColor;
  final Color? loaderColor;
  final Gradient? gradient;
  final bool needBorderColor;
  final bool isDisabled;
  final bool isLoader;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    this.height,
    this.width,
    this.text,
    this.svg,
    this.endSvg,
    this.borderColor,
    this.buttonColor,
    this.fontWeight,
    this.fontSize,
    this.textColor,
    this.loaderColor,
    this.onTap,
    this.padding,
    this.isDisabled = false,
    this.isLoader = false,
    this.disableButtonColor,
    this.loaderBoxSize,
    this.loaderStrokeWidth,
    this.disableTextColor,
    this.needBorderColor = false,
    this.borderRadius,
    this.gradient,
    this.fontFamily,
  });

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final buttonButton = (widget.isDisabled)
        ? widget.disableButtonColor ?? Palette.grey
        : widget.buttonColor ?? Palette.primary;
    return IgnorePointer(
      ignoring: widget.isLoader || widget.isDisabled,
      child: GestureDetector(
        onTap: (widget.isLoader || widget.isDisabled) ? null : widget.onTap,
        child: Container(
          height: widget.height,
          width: widget.width,
          padding: widget.padding ?? EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10.r),
            color: buttonButton,
            border: Border.all(
              color: (widget.needBorderColor) ? widget.borderColor ?? buttonButton : Colors.transparent,
            ),
            gradient: widget.gradient,
          ),
          child: Center(
            child: widget.isLoader
                ? CustomLoadingWidget(
                    color: widget.loaderColor ?? Palette.white,
                    size: widget.loaderBoxSize ?? 25.h,
                    strokeWidth: widget.loaderStrokeWidth,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (widget.svg != null)
                        Row(
                          children: [
                            SvgPicture.asset(
                              widget.svg!,
                              height: 20.h,
                            ),
                            8.w.horizontalSpace,
                          ],
                        ),
                      AppText(
                        text: widget.text ?? "",
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight ?? FontWeight.w600,
                        fontFamily: widget.fontFamily,
                        color: (widget.isDisabled)
                            ? widget.disableTextColor ?? Palette.greyText
                            : widget.textColor ?? Palette.white,
                      ),
                      if (widget.endSvg != null)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            8.w.horizontalSpace,
                            SvgPicture.asset(
                              widget.endSvg!,
                              height: 20.h,
                            ),
                          ],
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class BackArrowButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? buttonColor;

  const BackArrowButton({
    super.key,
    this.onTap,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? Navigation.pop,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 45.w,
        width: 45.w,
        decoration: BoxDecoration(
          border: Border.all(color: Palette.lightGrey),
          borderRadius: BorderRadius.circular(15.r),
          color: buttonColor,
        ),
        child: Center(
          child: SvgPicture.asset(
            IconAsset.backArrow,
            height: 20.h,
            width: 20.h,
          ),
        ),
      ),
    );
  }
}
