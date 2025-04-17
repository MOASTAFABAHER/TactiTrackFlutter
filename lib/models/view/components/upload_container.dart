import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/managers/color_manager.dart';

class UploadContainer extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var onTap, width, height, text, color, textColor, iconData, iconColor;
  UploadContainer(
      {super.key,
      required this.onTap,
      required this.iconColor,
      required this.iconData,
      required this.text,
      required this.width,
      required this.height,
      required this.textColor,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 1.sp,
        borderRadius: BorderRadius.circular(10.sp),
        color: ColorManager.whiteColor,
        shadowColor: Colors.white,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10.sp)),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  color: iconColor,
                  size: 50.sp,
                ),
                Text(text, style: TextStyle(color: textColor, fontSize: 20.sp)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
