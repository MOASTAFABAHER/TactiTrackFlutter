import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tacti_track/cubit/tacti_track/cubit/TactiTrack_cibit.dart';
import 'package:tacti_track/enums/toast_status.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/components/Custom_appbar.dart';

import '../../../config/toast_config.dart';
import '../components/upload_container.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TactiTrackCubit, TactiTrackState>(
      listener: (context, state) {
        if (state is TactiTrackUploadVideoLoadingState ||
            state is TactiTrackUploadImageLoadingState) {
          ToastConfig.showToast(
              msg:
                  'Your media has been successfully uploaded. Please hold on while the model processes and analyzes the content for detection.',
              toastStates: ToastStates.Success);
        }
        if (state is TactiTrackUploadVideoErrorState ||
            state is TactiTrackUploadImageErrorState) {
          ToastConfig.showToast(
            msg: 'Error while detecting',
            toastStates: ToastStates.Error,
          );
        }
        if (state is TactiTrackUploadVideoSuccessState ||
            state is TactiTrackUploadImageSuccessState) {
          ToastConfig.showToast(
              msg: state is TactiTrackUploadVideoSuccessState
                  ? 'Video successfully detected'
                  : 'Image successfully detected',
              toastStates: ToastStates.Success);
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
                                cubit.pickAndUpload(context, isVideo: true);
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
                                cubit.pickAndUpload(context, isVideo: false);
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
