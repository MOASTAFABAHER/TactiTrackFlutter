import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/app_root/tacti_track.dart';
import 'package:tacti_track/cubit/tacti_track/cubit/TactiTrack_cibit.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/components/upload_container_large.dart';
import 'package:toastification/toastification.dart';

class UploadVideoScreenLarge extends StatelessWidget {
  const UploadVideoScreenLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 100.h),
      child: BlocProvider(
        create: (context) => TactiTrackCubit(),
        child: BlocConsumer<TactiTrackCubit, TactiTrackState>(
          listener: (context, state) {
            if (state is TactiTrackUploadVideoSuccessState) {
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
          },
          builder: (context, state) {
            var cubit = TactiTrackCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(40.h),
                Text(
                  'Let the\n game Begin',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorManager.whiteColor,
                      fontSize: 12.sp),
                ),
                Gap(20.h),
                SizedBox(
                  width: 200.w,
                  child: Text(
                    'Stay tuned and keep an eye out! We’re excited to announce that real-time detection will be available very soon. Our team is working hard behind the scenes to bring this feature to life, and we can’t wait for you to experience it. It will enhance your experience and provide more accurate, real-time insights as you interact with the app. Stay with us—we\'re almost there!',
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: ColorManager.whiteColor,
                        fontSize: 4.sp),
                  ),
                ),
                Gap(70.h),
                MouseRegion(
                  child: Row(
                    children: [
                      UploadContainerLarge(
                          isLoading: state is TactiTrackUploadVideoLoadingState,
                          onTap: () {
                            state is TactiTrackUploadVideoLoadingState
                                ? null
                                : cubit.pickAndUpload(context, isVideo: true);
                          },
                          text: 'Upload Video',
                          containerColor: ColorManager.whiteColor,
                          textColor: ColorManager.greenColor),
                      SizedBox(
                        width: 3.w,
                      ),
                      UploadContainerLarge(
                          isLoading: state is TactiTrackUploadImageLoadingState,
                          onTap: () {
                            state is TactiTrackUploadImageLoadingState
                                ? null
                                : cubit.pickAndUpload(context, isVideo: false);
                          },
                          text: 'Upload Image',
                          containerColor: ColorManager.backgroundColor,
                          textColor: ColorManager.whiteColor),
                    ],
                  ),
                )

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     UploadContainerLarge(
                //         ontap: () {},
                //         description:
                //             'Just upload video and get player positions,referees, detection and ball tracking and more 🔥',
                //         text: 'Upload Match Video',
                //         iconData: Icons.upload,
                //         iconColor: ColorManager.whiteColor,
                //         textColor: ColorManager.whiteColor,
                //         color: ColorManager.greenColor,
                //         width: 80.w,
                //         height: 250.h),
                //     UploadContainerLarge(
                //         ontap: () {},
                //         description:
                //             'Upload your image and get player positions,referees, detection and ball tracking',
                //         text: 'Upload Image',
                //         iconData: Icons.upload,
                //         iconColor: ColorManager.whiteColor,
                //         textColor: ColorManager.whiteColor,
                //         color: ColorManager.greenColor,
                //         width: 80.w,
                //         height: 250.h),
                //   ],
                // ),
                // Gap(10.h),
                // Container(
                //   padding: EdgeInsets.all(6.sp),
                //   width: 170.w,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10.sp),
                //     color: ColorManager.geryColor,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Note About RealTime',
                //         style: TextStyle(
                //             fontSize: 6.sp,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.black),
                //       ),
                //       Gap(8.h),
                //       Text(
                //         'Stay tuned and keep an eye out! We’re excited to announce that real-time detection will be available very soon. Our team is working hard behind the scenes to bring this feature to life, and we can’t wait for you to experience it. It will enhance your experience and provide more accurate, real-time insights as you interact with the app. Stay with us—we\'re almost there!',
                //         style: TextStyle(
                //             fontSize: 4.sp,
                //             fontWeight: FontWeight.w400,
                //             color: Colors.black),
                //       ),
                //     ],
                //   ),
                // )
              ],
            );
          },
        ),
      ),
    );
  }
}
