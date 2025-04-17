// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/managers/color_manager.dart';

class OnBoardingWebCopmonent extends StatefulWidget {
  String title, imagePath, description;
  OnBoardingWebCopmonent(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.description});

  @override
  State<OnBoardingWebCopmonent> createState() => _OnBoardingWebCopmonentState();
}

class _OnBoardingWebCopmonentState extends State<OnBoardingWebCopmonent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2, // <-- elevation on hover
        borderRadius: BorderRadius.circular(10.sp),
        shadowColor: ColorManager.whiteColor.withOpacity(0.5),
        child: AnimatedContainer(
          padding: EdgeInsets.all(4.sp),
          duration: const Duration(milliseconds: 200),
          width: 90.w,
          height: 400.h,
          decoration: BoxDecoration(
            color: ColorManager.backgroundColor,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Column(
            children: [
              Gap(2.h),
              Image.asset(
                widget.imagePath,
                height: 200.h,
                fit: BoxFit.fill,
              ),
              Gap(10.h),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 8.sp,
                  color: ColorManager.whiteColor,
                ),
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 4.sp,
                  color: ColorManager.geryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
