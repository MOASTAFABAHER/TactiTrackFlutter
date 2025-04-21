import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/cubit/tacti_track/cubit/TactiTrack_cubit.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/Screens/video_player_screen.dart';
import 'package:tacti_track/models/view/components/Custom_appbar.dart';
import 'package:tacti_track/models/view/components/bottom_sheet.dart';
import 'package:toastification/toastification.dart';

import '../../../utils/app_navigator.dart';
import '../components/upload_container.dart';
import 'image_viewer_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TactiTrackCubit, TactiTrackState>(
      listener: (context, state) {
        if (state is PickDataSucssessState) {
          myShowBottomSheet(context,
              isVideo: TactiTrackCubit.get(context).isVideo!, onTapStart: () {
            Navigator.pop(context);
            TactiTrackCubit.get(context)
                .snedData(isVideo: TactiTrackCubit.get(context).isVideo!);
          });
        }

        if (state is TactiTrackUploadVideoSuccessState) {
          AppNavigator.appNavigator(
              context,
              VideoPlayerScreen(
                  videoUrl: TactiTrackCubit.get(context).videoUrl!));
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.flat,
            title: const Text("Video successfully detected"),
            description:
                const Text("Your video has been successfully detecteds."),
            alignment: Alignment.bottomCenter,
            autoCloseDuration: const Duration(seconds: 4),
            borderRadius: BorderRadius.circular(100.0),
            applyBlurEffect: true,
          );
        }
        if (state is TactiTrackUploadImageSuccessState) {
          AppNavigator.appNavigator(
              context,
              ImageViewerScreen(
                imageUrl: TactiTrackCubit.get(context).imageUrl!,
              ));
        }
      },
      builder: (context, state) {
        var cubit = TactiTrackCubit.get(context);
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppbar(text: "TactiTrack"),
                Gap(10.h),
                Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload your Media',
                        style: TextStyle(
                            fontSize: 20.sp, color: ColorManager.whiteColor),
                      ),
                      Gap(20.h),
                      state is TactiTrackUploadVideoLoadingState
                          ? Container(
                              height: 150.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: ColorManager.greenColor),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorManager.whiteColor,
                                ),
                              ),
                            )
                          : UploadContainer(
                              iconColor: ColorManager.whiteColor,
                              iconData: Icons.upload_file,
                              text: 'Upload Match Video',
                              height: 150.h,
                              width: double.infinity,
                              color: ColorManager.greenColor,
                              textColor: ColorManager.whiteColor,
                              onTap: () {
                                cubit.pickData(isVideo: true);
                                cubit.isVideo = true;

                                // cubit.pickAndUpload(context, isVideo: true);
                              },
                            ),
                      Gap(10.h),
                      state is TactiTrackUploadImageLoadingState
                          ? Container(
                              height: 150.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  color: ColorManager.whiteColor),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: ColorManager.greenColor,
                                ),
                              ),
                            )
                          : UploadContainer(
                              iconColor: ColorManager.greenColor,
                              iconData: Icons.image,
                              text: 'Upload Image',
                              onTap: () {
                                cubit.pickData(isVideo: false);
                                cubit.isVideo = false;
                              },
                              width: double.infinity,
                              height: 150.h,
                              textColor: ColorManager.greenColor,
                              color: ColorManager.whiteColor),
                      Gap(10.h),
                      Container(
                        padding: EdgeInsets.all(16.sp),
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.sp),
                          color: ColorManager.geryColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Note About RealTime',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                            Gap(8.h),
                            Text(
                              'Stay tuned and keep an eye out! We’re excited to announce that real-time detection will be available very soon. Our team is working hard behind the scenes to bring this feature to life, and we can’t wait for you to experience it. It will enhance your experience and provide more accurate, real-time insights as you interact with the app. Stay with us—we\'re almost there!',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
