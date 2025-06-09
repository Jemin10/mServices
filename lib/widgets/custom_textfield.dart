import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/utils.dart';
import 'package:mservices/widgets/app_text.dart';

class CommonTextField extends StatelessWidget {
  final bool readOnly;
  final TextEditingController? controller;
  final int? maxLine;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? minLines;
  final double? cpVertical;
  final double? cpHorizontal;
  final double? radius;
  final double? textSize;
  final double? hintTextSize;
  final double? iconSize;
  final double? errorTextSize;
  final Color? textColor;
  final Color? hintTextColor;
  final Color? errorTextColor;
  final FontWeight? textWeight;
  final FontWeight? hintTextWeight;
  final FontWeight? errorTextWeight;
  final bool enabled;
  final FocusNode? focusNode;
  final String? hintText;
  final String? prefixIcon;
  final TextAlign? textAlign;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final VoidCallback? onTap;
  final String? Function(String?)? onSubmit;
  final Color? enableColor;
  final Color? focusedColor;
  final Color? cursorColor;
  final TextCapitalization textCapitalization;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final BoxConstraints? constraints;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final String? Function(String?)? validator;
  final String? Function(PointerDownEvent?)? onTapOutSide;
  final bool isPassword;
  final bool isIgnoreContentPadding;

  CommonTextField({
    super.key,
    this.onChanged,
    this.minLines,
    this.iconSize,
    this.maxLine,
    this.maxLength,
    this.radius,
    this.fillColor,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.hintText,
    this.textAlign,
    this.prefix,
    this.suffix,
    this.onTap,
    this.enableColor,
    this.focusedColor,
    this.cursorColor,
    this.borderColor,
    this.focusedBorderColor,
    this.controller,
    this.prefixWidget,
    this.suffixWidget,
    this.prefixIcon,
    this.textCapitalization = TextCapitalization.none,
    this.readOnly = false,
    this.inputFormatters,
    this.constraints,
    this.prefixConstraints,
    this.suffixConstraints,
    this.textSize,
    this.hintTextSize,
    this.errorTextSize,
    this.textColor,
    this.hintTextColor,
    this.errorTextColor,
    this.textWeight,
    this.hintTextWeight,
    this.errorTextWeight,
    this.validator,
    this.cpVertical,
    this.cpHorizontal,
    this.isPassword = false,
    this.isIgnoreContentPadding = false,
    this.onSubmit,
    this.onTapOutSide,
  });

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isObscure,
      builder: (context, bool isObscure, _) {
        if (!isPassword) {
          isObscure = false;
        }

        return TextFormField(
          readOnly: readOnly,
          style: TextStyle(
            color: textColor ?? Palette.text,
            fontWeight: textWeight ?? FontWeight.w500,
            fontSize: textSize ?? 14.sp,
            fontFamily: FontFamily.inter,
          ),
          onTap: onTap,
          onFieldSubmitted: onSubmit,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          controller: controller,
          maxLines: maxLine ?? 1,
          minLines: minLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          focusNode: focusNode,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: cursorColor ?? Palette.primary,
          textAlign: textAlign ?? TextAlign.start,
          textCapitalization: textCapitalization,
          enabled: enabled,
          obscureText: isPassword ? _isObscure.value : false,
          onTapOutside: (event) => Utils.hideKeyboardInApp(context),
          validator: validator,
          decoration: InputDecoration(
            prefix: prefixWidget,
            suffix: suffixWidget,
            contentPadding: !isIgnoreContentPadding
                ? EdgeInsets.symmetric(horizontal: cpHorizontal ?? 15.w, vertical: cpVertical ?? 15.h)
                : null,
            prefixIcon: prefixIcon != null
                ? Container(
                    width: 45.w,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 15.w),
                    child: SvgPicture.asset(
                      prefixIcon ?? "",
                      height: iconSize ?? 20.w,
                      width: iconSize ?? 20.w,
                    ),
                  )
                : prefix,
            errorMaxLines: 3,
            suffixIcon: suffix == null && isPassword
                ? GestureDetector(
                    onTap: () => _isObscure.value = !isObscure,
                    behavior: HitTestBehavior.translucent,
                    child: SizedBox(
                      width: 48.w,
                      child: Center(
                        child: SvgPicture.asset(
                          isObscure ? IconAsset.eyeOpen : IconAsset.eyeClose,
                          height: iconSize ?? 20.w,
                          width: iconSize ?? 20.w,
                        ),
                      ),
                    ),
                  )
                : suffix,
            prefixIconConstraints: prefixConstraints,
            suffixIconConstraints: suffixConstraints,
            counterText: "",
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintTextColor ?? Palette.hintGrey,
              fontWeight: hintTextWeight ?? FontWeight.w400,
              fontSize: hintTextSize ?? 14.sp,
              fontFamily: FontFamily.inter,
            ),
            errorStyle: TextStyle(
              color: errorTextColor ?? Palette.red,
              fontWeight: errorTextWeight ?? FontWeight.w400,
              fontSize: errorTextSize ?? 12.sp,
              fontFamily: FontFamily.inter,
            ),
            filled: true,
            fillColor: fillColor ?? Palette.white,
            constraints: constraints,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 12.r)),
              borderSide: BorderSide(color: borderColor ?? Palette.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 12.r)),
              borderSide: BorderSide(color: borderColor ?? Palette.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 12.r)),
              borderSide: BorderSide(color: focusedBorderColor ?? Palette.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 12.r)),
              borderSide: BorderSide(color: Palette.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 12.r)),
              borderSide: BorderSide(color: Palette.red),
            ),
          ),
        );
      },
    );
  }
}

class TitleFieldWidget extends StatelessWidget {
  const TitleFieldWidget({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.h,
      children: [
        AppText(
          text: title,
          fontSize: 14.sp,
          color: Palette.greyText,
        ),
        child,
      ],
    );
  }
}
