import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tacti_track/cubit/tacti_track/cubit/TactiTrack_cubit.dart';

import 'package:tacti_track/models/view/Screens/on_boarding/on_boarding_screen.dart';
import 'package:tacti_track/models/view/Screens/on_boarding/on_boarding_screen_large.dart';

class TactiTrack extends StatelessWidget {
  const TactiTrack({super.key});

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return BlocProvider(
          create: (context) => TactiTrackCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashFactory: NoSplash.splashFactory,
            ),
            home: Platform.isWindows ||
                    Platform.isLinux ||
                    Platform.isMacOS ||
                    kIsWeb
                ? const OnBoardingScreenLarge()
                : const OnboardingScreenMobile(),
          ),
        );
      },
    );
  }
}
