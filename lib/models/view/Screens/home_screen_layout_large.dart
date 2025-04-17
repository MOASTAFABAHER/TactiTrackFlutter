import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/Screens/history_screen_large.dart';
import 'package:tacti_track/models/view/Screens/upload_video_large.dart';
import 'dart:ui';

import 'package:tacti_track/models/view/components/appbar_button_large.dart';
import 'package:tacti_track/models/view/components/window_tile_bar/main_layout.dart';

class HomeScreenLayoutLarge extends StatefulWidget {
  const HomeScreenLayoutLarge({super.key});

  @override
  State<HomeScreenLayoutLarge> createState() => _HomeScreenLayoutLargeState();
}

class _HomeScreenLayoutLargeState extends State<HomeScreenLayoutLarge> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _videosKey = GlobalKey();
  bool isHome = true;
  bool isVideo = false;
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(children: [
                Text(
                  'TactiTrack',
                  style: TextStyle(
                    color: ColorManager.whiteColor,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                //Home tab
                AppbarButtonLarge(
                    is_selected: isHome,
                    text: 'Home',
                    onTap: () {
                      isVideo = false;
                      isHome = true;
                      setState(() {});
                      _scrollToSection(_homeKey);
                    },
                    containerColor: ColorManager.whiteColor,
                    textColor: ColorManager.whiteColor),
                SizedBox(
                  width: 5.w,
                ), // Detected Videos tab
                AppbarButtonLarge(
                    is_selected: isVideo,
                    isVideo: true,
                    text: 'Deteceted Videos ',
                    onTap: () {
                      isHome = false;
                      isVideo = true;
                      setState(() {});
                      _scrollToSection(_videosKey);
                    },
                    containerColor: ColorManager.backgroundColor,
                    textColor: ColorManager.whiteColor)
              ]),

              Divider(color: ColorManager.whiteColor),

              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Home section
                      SizedBox(
                        key: _homeKey,
                        height: 700.h,
                        width: double.infinity,
                        child: const UploadVideoScreenLarge(),
                      ),

                      // Detected Videos section
                      Container(
                          key: _videosKey, child: const HistoryScreenLarge()),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
