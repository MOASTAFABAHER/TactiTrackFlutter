import 'package:flutter/material.dart';
import 'package:tacti_track/domain/local/sp__keys.dart';
import 'package:tacti_track/domain/local/sp_helper.dart';
import 'package:tacti_track/models/view/components/Custom_appbar.dart';
import 'package:tacti_track/models/view/components/Video_player_container.dart';

class HistoryDetectedScreen extends StatefulWidget {
  const HistoryDetectedScreen({super.key});

  @override
  State<HistoryDetectedScreen> createState() => _HistoryDetectedScreenState();
}

class _HistoryDetectedScreenState extends State<HistoryDetectedScreen> {
  late List<String> videoPaths;

  @override
  void initState() {
    videoPaths = SharedPrefrenceHelper.getStringList(
        key: SharedPreferencesKeys.videoPaths);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppbar(text: 'History of Detection'),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: videoPaths.length,
              itemBuilder: (context, index) {
                return VideoPlayerContainer(
                  videoUrl: videoPaths[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
