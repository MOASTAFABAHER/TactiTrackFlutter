import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tacti_track/managers/color_manager.dart';

class AppbarButtonLarge extends StatefulWidget {
  dynamic onTap;
  Color containerColor, textColor;
  String text;
  bool isVideo, is_selected;

  AppbarButtonLarge(
      {super.key,
      required this.text,
      required this.onTap,
      required this.is_selected,
      this.isVideo = false,
      required this.containerColor,
      required this.textColor});

  @override
  State<AppbarButtonLarge> createState() => _AppbarButtonLargeState();
}

class _AppbarButtonLargeState extends State<AppbarButtonLarge> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: widget.is_selected & !isHover
                ? Colors.white
                : widget.is_selected & isHover
                    ? ColorManager.whiteColor.withValues(alpha: 0.5)
                    : widget.isVideo & isHover
                        ? ColorManager.whiteColor.withValues(alpha: 0.5)
                        : widget.isVideo & !isHover
                            ? widget.containerColor
                            : !widget.isVideo & isHover
                                ? widget.containerColor.withValues(alpha: 0.5)
                                : ColorManager.backgroundColor,
            borderRadius: BorderRadius.circular(2.sp),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.is_selected
                    ? ColorManager.greenColor
                    : widget.textColor,
                fontSize: 4.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
