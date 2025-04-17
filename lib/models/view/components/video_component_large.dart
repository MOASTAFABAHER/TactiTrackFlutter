import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tacti_track/domain/local/sp_helper.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/local/sp__keys.dart';

class VideoComponentLarge extends StatefulWidget {
  String? videoUrl;
  VideoComponentLarge({super.key, required this.videoUrl});

  @override
  State<VideoComponentLarge> createState() => _VideoComponentLargeState();
}

class _VideoComponentLargeState extends State<VideoComponentLarge> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));

    // First wait for initialization to complete
    try {
      await _videoPlayerController.initialize();
    } catch (e) {
      SharedPrefrenceHelper.removeData(key: SharedPreferencesKeys.videoPaths);
      setState(() {});
    }

    // Show first frame immediately
    await _videoPlayerController.seekTo(Duration.zero);

    // Set up Chewie controller
    _chewieController = ChewieController(
        showControlsOnInitialize: false,
        // additionalOptions: (context) {
        //   return <OptionItem>[
        //     OptionItem(
        //         onTap: widget.onTapDownload,
        //         iconData: Icons.download,
        //         title: 'Download'),
        //   ];
        // },
        hideControlsTimer: const Duration(seconds: 1),
        videoPlayerController: _videoPlayerController,
        autoInitialize: true,
        autoPlay: false, // Don't autoplay immediately
        looping: false,
        aspectRatio: _videoPlayerController.value.aspectRatio,
        allowFullScreen: true,
        showControls: true,
        pauseOnBackgroundTap: true);

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }

    // Play for 1 second then pause
    _videoPlayerController.play();
    Future.delayed(const Duration(milliseconds: 700), () {
      if (mounted && _videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _videoPlayerController.seekTo(Duration.zero);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 20.h),
            child: Container(
              height: 400.h,
              decoration: BoxDecoration(
                  color: ColorManager.backgroundColor,
                  borderRadius: BorderRadius.circular(10.sp)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: SizedBox(
                      child: AspectRatio(
                        aspectRatio: _chewieController!
                            .videoPlayerController.value.aspectRatio,
                        child: SizedBox(
                          child: Chewie(
                            controller: _chewieController!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
