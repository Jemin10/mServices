import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mservices/utils/palette.dart';

class BottomItem extends StatelessWidget {
  const BottomItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            height: 35.h,
            width: 55.w,
            decoration: BoxDecoration(
              color: isSelected ? Palette.primary : Palette.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                height: 25.h,
                colorFilter: ColorFilter.mode(
                  isSelected ? Palette.secondary : Palette.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
