import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tacti_track/managers/color_manager.dart';

class StartButton extends StatefulWidget {
  String text;
  dynamic onTap;
  bool isClose;

  StartButton(
      {super.key,
      required this.text,
      required this.isClose,
      required this.onTap});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  Color color = ColorManager.backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        widget.isClose
            ? color = Colors.red
            : color = ColorManager.whiteColor.withValues(alpha: 0.6);
        setState(() {});
      },
      onExit: (event) {
        color = ColorManager.backgroundColor;
        setState(() {});
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: EdgeInsets.all(2.sp),
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2.sp)),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(color: ColorManager.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
