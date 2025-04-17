import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../managers/color_manager.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget {
  String text;
  CustomAppbar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(Platform.isWindows ? 0.h : 20.h),
        Text(
          text,
          style: TextStyle(
              color: ColorManager.whiteColor,
              fontSize: Platform.isWindows ? 10.sp : 25.sp,
              fontWeight: FontWeight.bold),
        ),
        Divider(thickness: 1, color: ColorManager.geryColor),
        Gap(10.h),
      ],
    );
  }
}
