import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/components/start_button_popup.dart';

import 'bottom_sheet_button.dart' show BottomSheetButton;

class PopupDesktop extends StatelessWidget {
  bool isVideo;
  dynamic onTapStart;

  PopupDesktop({
    super.key,
    required this.isVideo,
    required this.onTapStart,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.sp)),
        backgroundColor: ColorManager.backgroundColor,
        title: const Text('Additional Analysis',
            style: TextStyle(color: Colors.white)),
        content: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  BottomSheetButton(
                    text: 'Zone Control',
                    description:
                        'The screen is divided into 6 zones. Each zone is analyzed to determine which team controls it based on the number of players present from each team. This provides insight into territorial dominance across the pitch.',
                    ispass: false,
                  ),
                  Gap(20.h),
                  isVideo
                      ? BottomSheetButton(
                          ispass: true,
                          text: 'pass lines ',
                          description:
                              "When a player gains possession of the ball, the system draws all possible passing options by identifying teammates within a reachable distance. This helps visualize potential playmaking opportunities",
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StartButton(
                  text: 'Close',
                  isClose: true,
                  onTap: () {
                    Navigator.pop(context);
                  }),
              SizedBox(
                width: 5.w,
              ),
              StartButton(text: 'Start', isClose: false, onTap: onTapStart),
            ],
          )
        ]);
  }
}
