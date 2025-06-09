import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mservices/utils/palette.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.color,
    this.size,
    this.strokeWidth,
  });

  final double? size;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 30.w,
      height: size ?? 30.w,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 2.5.w,
          color: color,
        ),
      ),
    );
  }
}

class OverlayLoader extends StatelessWidget {
  const OverlayLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      color: Palette.black.withValues(alpha: 0.5),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
