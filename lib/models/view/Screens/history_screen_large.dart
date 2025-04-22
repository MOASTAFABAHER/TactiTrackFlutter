import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tacti_track/cubit/tacti_track/cubit/TactiTrack_cubit.dart';
import 'package:tacti_track/domain/local/sp__keys.dart';
import 'package:tacti_track/models/view/components/video_component_large.dart';

import '../../../domain/local/sp_helper.dart';

class HistoryScreenLarge extends StatefulWidget {
  const HistoryScreenLarge({super.key});

  @override
  State<HistoryScreenLarge> createState() => _HistoryScreenLargeState();
}

class _HistoryScreenLargeState extends State<HistoryScreenLarge> {
  late List<String> videoPaths;

  @override
  void initState() {
    videoPaths = SharedPrefrenceHelper.getStringList(
        key: SharedPreferencesKeys.videoPaths);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TactiTrackCubit, TactiTrackState>(
      listener: (context, state) {
        if (state is TactiTrackUploadVideoSuccessState) {
          videoPaths = SharedPrefrenceHelper.getStringList(
              key: SharedPreferencesKeys.videoPaths);
          setState(() {});
        }
      },
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: videoPaths.length,
          itemBuilder: (context, index) {
            return VideoComponentLarge(
              videoUrl: videoPaths[index],
            );
          }),
    );
  }
}
