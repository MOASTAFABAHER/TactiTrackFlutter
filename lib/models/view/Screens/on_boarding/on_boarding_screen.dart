import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/models/view/Screens/home_screen_layout_mobile.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/onboarding_init.dart';
import 'package:tacti_track/utils/app_navigator.dart';

class OnboardingScreenMobile extends StatefulWidget {
  const OnboardingScreenMobile({super.key});

  @override
  State<OnboardingScreenMobile> createState() => _OnboardingScreenMobileState();
}

class _OnboardingScreenMobileState extends State<OnboardingScreenMobile> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < onboardingPages.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      // Navigate to your main app screen
      AppNavigator.appNavigator(context, const HomeScreenLayout(),
          isFinished: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: PageView.builder(
        controller: _pageController,
        itemCount: onboardingPages.length,
        onPageChanged: (index) => setState(() => currentIndex = index),
        itemBuilder: (context, index) {
          final page = onboardingPages[index];
          return Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                Gap(60.h),
                Text(page.title,
                    style: TextStyle(
                        color: ColorManager.whiteColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                Text(page.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.sp, color: ColorManager.geryColor)),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 330.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(page.imageAsset), fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(16.sp)),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () =>
                  AppNavigator.appNavigator(context, const HomeScreenLayout()),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: ColorManager.backgroundColor,
                ),
              ),
            ),
            Row(
              children: List.generate(
                onboardingPages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: nextPage,
              child: Text(
                currentIndex == onboardingPages.length - 1
                    ? "Get Started"
                    : "Next",
                style: TextStyle(color: ColorManager.backgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
