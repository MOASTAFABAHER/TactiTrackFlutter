import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../managers/color_manager.dart';

class UploadContainerLarge extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  String text;
  Color containerColor, textColor;
  bool isLoading;
  dynamic onTap;
  UploadContainerLarge(
      {super.key,
      required this.text,
      required this.containerColor,
      required this.isLoading,
      required this.textColor,
      required this.onTap});

  @override
  State<UploadContainerLarge> createState() => _UploadContainerLargeState();
}

class _UploadContainerLargeState extends State<UploadContainerLarge> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: Material(
          elevation: 1,
          shadowColor: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(5.sp),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(4.sp),
            width: 60.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              color: widget.containerColor == ColorManager.whiteColor
                  ? isHovered
                      ? ColorManager.greyDarkColor.withValues(alpha: 0.5)
                      : widget.containerColor
                  : isHovered
                      ? widget.containerColor.withValues(alpha: 0.5)
                      : widget.containerColor,
            ),
            child: Center(
              child: widget.isLoading
                  ? CircularProgressIndicator(
                      color: widget.textColor,
                    )
                  : Text(
                      widget.text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 4.sp,
                          color: widget.textColor),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
