import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mservices/utils/assets.dart';
import 'package:mservices/utils/constants.dart';
import 'package:mservices/utils/palette.dart';
import 'package:mservices/utils/screen_size.dart';
import 'package:mservices/widgets/app_text.dart';

class CommonDropDown<T> extends StatelessWidget {
  final void Function(T?) onChanged;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final String hintText;
  final Color? hintTextColor;
  final Color? focusedBorderColor;
  final FontWeight? hintTextWeight;
  final double? hintTextSize;
  final Color? textColor;
  final FontWeight? textWeight;
  final double? textSize;
  final Color? errorTextColor;
  final FontWeight? errorTextWeight;
  final double? errorTextSize;
  final String? Function(T?)? validator;
  final Color? fillColor;
  final double? radius;
  final double? iconMargin;
  final double? menuSize;
  final double? borderWidth;
  final Color? borderColor;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const CommonDropDown({
    super.key,
    required this.onChanged,
    this.value,
    required this.items,
    required this.itemAsString,
    required this.hintText,
    this.hintTextColor,
    this.hintTextWeight,
    this.hintTextSize,
    this.errorTextColor,
    this.errorTextWeight,
    this.errorTextSize,
    this.textColor,
    this.textWeight,
    this.textSize,
    this.validator,
    this.fillColor,
    this.radius,
    this.iconMargin,
    this.contentPadding,
    this.borderColor,
    this.dropdownItems,
    this.selectedItemBuilder,
    this.menuSize,
    this.focusedBorderColor,
    this.borderWidth,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isDense: true,
      isExpanded: true,
      alignment: Alignment.centerLeft,
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        height: 35.h,
      ),
      hint: AppText(
        text: hintText,
        color: hintTextColor ?? Palette.hintGrey,
        fontWeight: hintTextWeight ?? FontWeight.w400,
        fontSize: hintTextSize ?? 14.sp,
      ),
      style: TextStyle(
        color: textColor ?? Palette.black,
        fontWeight: textWeight ?? FontWeight.w500,
        fontSize: textSize ?? 14.sp,
        fontFamily: FontFamily.inter,
      ),
      items: dropdownItems ??
          items.map(
            (item) {
              return DropdownMenuItem<T>(
                value: item,
                child: AppText(
                  text: itemAsString(item),
                  color: textColor ?? Palette.black,
                  fontWeight: textWeight ?? FontWeight.w400,
                  fontSize: textSize ?? 14.sp,
                  maxLines: 1,
                ),
              );
            },
          ).toList(),
      value: value,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 13.h),
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
        fillColor: fillColor ?? Palette.white,
        filled: true,
        isDense: true,
        alignLabelWithHint: true,
        errorStyle: TextStyle(
          color: errorTextColor ?? Palette.red,
          fontWeight: errorTextWeight ?? FontWeight.w400,
          fontSize: errorTextSize ?? 12.sp,
          fontFamily: FontFamily.inter,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        elevation: 0,
        maxHeight: menuSize ?? ScreenSize.height / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Palette.white,
        ),
      ),
      iconStyleData: IconStyleData(
        icon: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            alignment: Alignment.center,
            child: RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(
                IconAsset.backArrow,
                height: 14.h,
              ),
            ),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
