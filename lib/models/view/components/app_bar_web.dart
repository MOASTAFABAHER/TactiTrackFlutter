import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../managers/color_manager.dart';

class AppBarWeb extends StatelessWidget {
  const AppBarWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'TactiTrack',
          style: TextStyle(fontSize: 8.sp, color: ColorManager.whiteColor),
        ),
      ],
    );
  }
}
