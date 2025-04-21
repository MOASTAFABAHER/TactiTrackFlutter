import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/components/bottom_sheet_button.dart';

void myShowBottomSheet(context, {dynamic onTapStart, required bool isVideo}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(8.sp),
          height: 300.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.sp),
                  topRight: Radius.circular(10.sp)),
              color: ColorManager.backgroundColor),
          child: Column(
            children: [
              Text(
                'Additional Analysis',
                style: TextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              Gap(5.h),
              BottomSheetButton(
                text: 'Zone Control',
                description:
                    'The screen is divided into 6 zones. Each zone is analyzed to determine which team controls it based on the number of players present from each team. This provides insight into territorial dominance across the pitch.',
                ispass: false,
              ),
              Gap(5.h),
              isVideo
                  ? BottomSheetButton(
                      ispass: true,
                      text: 'pass lines ',
                      description:
                          "When a player gains possession of the ball, the system draws all possible passing options by identifying teammates within a reachable distance. This helps visualize potential playmaking opportunities",
                    )
                  : const SizedBox(),
              const Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: onTapStart,
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: ColorManager.whiteColor),
                  child: Center(
                    child: Text(
                      'Start',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: ColorManager.backgroundColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
