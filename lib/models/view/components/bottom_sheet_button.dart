import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/cubit/tacti_track/cubit/TactiTrack_cubit.dart';
import 'package:tacti_track/managers/color_manager.dart' show ColorManager;

// ignore: must_be_immutable
class BottomSheetButton extends StatefulWidget {
  String text, description;
  bool ispass;

  BottomSheetButton(
      {super.key,
      required this.text,
      required this.ispass,
      required this.description});

  @override
  State<BottomSheetButton> createState() => _BottomSheetButtonState();
}

class _BottomSheetButtonState extends State<BottomSheetButton> {
  Color color = ColorManager.whiteColor;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TactiTrackCubit, TactiTrackState>(
      builder: (context, state) {
        var cubit = TactiTrackCubit.get(context);
        return MouseRegion(
          onHover: (event) {
            color = color.withValues(alpha: 0.7);
            setState(() {});
          },
          onExit: (event) {
            color = ColorManager.whiteColor;
            setState(() {});
          },
          child: GestureDetector(
            onTap: () {
              widget.ispass
                  ? cubit.changeIsPassSelected()
                  : cubit.changeIsZoneSelected();
              setState(() {});
            },
            child: Container(
              padding: EdgeInsets.all(
                  Platform.isAndroid || Platform.isIOS ? 8.sp : 1.sp),
              width: Platform.isAndroid || Platform.isIOS
                  ? double.infinity
                  : 200.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      Platform.isAndroid || Platform.isIOS ? 10.sp : 2.sp),
                  color: color),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 3.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: ColorManager.backgroundColor,
                            fontSize: Platform.isAndroid || Platform.isIOS
                                ? 14.sp
                                : 6.sp,
                          ),
                        ),
                        Gap(Platform.isAndroid || Platform.isIOS ? 4.h : 1.h),
                        SizedBox(
                          width: Platform.isAndroid || Platform.isIOS
                              ? 280.w
                              : 150.w,
                          child: Text(
                            widget.description,
                            softWrap: true,
                            style: TextStyle(
                              color: ColorManager.backgroundColor,
                              fontSize: Platform.isAndroid || Platform.isIOS
                                  ? 10.sp
                                  : 3.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  CircleAvatar(
                    radius: Platform.isAndroid || Platform.isIOS ? 11.sp : 5.sp,
                    backgroundColor: ColorManager.backgroundColor,
                    child: CircleAvatar(
                      radius:
                          Platform.isAndroid || Platform.isIOS ? 10.sp : 5.sp,
                      backgroundColor: widget.ispass && cubit.ispassSelected
                          ? ColorManager.greenColor
                          : !widget.ispass && cubit.isZoneSelected
                              ? ColorManager.greenColor
                              : ColorManager.whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
