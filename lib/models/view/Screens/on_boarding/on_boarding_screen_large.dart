import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/Screens/home_screen_layout_large.dart';
import 'package:tacti_track/models/view/components/app_bar_web.dart';
import 'package:tacti_track/models/view/components/on_boarding_web_copmonent.dart';
import 'package:tacti_track/models/view/components/window_tile_bar/main_layout.dart';
import 'package:tacti_track/models/view/components/window_tile_bar/window_tile_bar.dart';
import 'package:tacti_track/utils/app_navigator.dart';

class OnBoardingScreenLarge extends StatefulWidget {
  const OnBoardingScreenLarge({super.key});

  @override
  State<OnBoardingScreenLarge> createState() => _OnBoardingScreenLargeState();
}

class _OnBoardingScreenLargeState extends State<OnBoardingScreenLarge> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 15.w),
          child: Column(
            children: [
              const AppBarWeb(),
              Gap(20.h),
              Text(
                'Ready To Use TactiTrack...❔',
                style:
                    TextStyle(color: ColorManager.whiteColor, fontSize: 12.sp),
              ),
              Text(
                'TactiTrack is an AI-powered football analysis tool that tracks players, ball movement, and team tactics in real time.',
                style: TextStyle(
                    fontSize: 4.sp,
                    fontWeight: FontWeight.w300,
                    color: ColorManager.whiteColor),
              ),
              Gap(10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OnBoardingWebCopmonent(
                    title: 'Welcome to TactiTrack',
                    description: 'Your smart football analyst ⚡',
                    imagePath: 'assets/images/tacti_track_mind.png',
                  ),
                  OnBoardingWebCopmonent(
                    title: 'Analyze Any Football Match',
                    description:
                        'Just upload video and get player positions,referees, detection and ball tracking and more 🔥',
                    imagePath: 'assets/images/upload_image.png',
                  ),
                  OnBoardingWebCopmonent(
                    title: 'See The Game Like a Coach',
                    description:
                        'Visualize player positions and ball tracking 🚀',
                    imagePath: 'assets/images/tacti_track.png',
                  ),
                ],
              ),
              Gap(10.h),
              GestureDetector(
                onTap: () {
                  AppNavigator.appNavigator(
                      context, const HomeScreenLayoutLarge(),
                      isFinished: true);
                },
                child: MouseRegion(
                  onEnter: (_) => setState(() => isHovered = true),
                  onExit: (_) => setState(() => isHovered = false),
                  child: Material(
                    elevation: isHovered ? 8 : 2,
                    borderRadius: BorderRadius.circular(50.sp),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 60.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.sp),
                          color: isHovered
                              ? ColorManager.greenColor.withValues(
                                  alpha: 0.5,
                                )
                              : ColorManager.greenColor),
                      child: Center(
                          child: Text(
                        'Get Started',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 6.sp,
                            color: ColorManager.whiteColor),
                      )),
                    ),
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
