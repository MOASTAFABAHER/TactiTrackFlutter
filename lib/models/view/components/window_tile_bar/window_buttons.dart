import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../managers/color_manager.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.backgroundColor),
      child: Row(
        children: [
          MinimizeWindowButton(
            colors: WindowButtonColors(
                mouseOver: ColorManager.greenColor,
                iconNormal: ColorManager.whiteColor,
                iconMouseOver: ColorManager.whiteColor),
          ),
          MaximizeWindowButton(
            colors: WindowButtonColors(
                mouseOver: ColorManager.greenColor,
                iconNormal: ColorManager.whiteColor,
                iconMouseOver: ColorManager.whiteColor),
          ),
          CloseWindowButton(
            colors: WindowButtonColors(
                mouseOver: Colors.red,
                iconNormal: ColorManager.whiteColor,
                iconMouseOver: ColorManager.whiteColor),
          ),
        ],
      ),
    );
  }
}
