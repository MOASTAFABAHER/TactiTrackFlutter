import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: videoPaths.length,
        itemBuilder: (context, index) {
          return VideoComponentLarge(
            videoUrl: videoPaths[index],
          );
        });
  }
}
