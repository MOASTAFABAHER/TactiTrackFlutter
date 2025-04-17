import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tacti_track/models/view/components/window_tile_bar/main_layout.dart';
import 'package:video_player/video_player.dart';

import '../../../managers/color_manager.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      autoInitialize: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      allowFullScreen: true,
      fullScreenByDefault: false,
    );

    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        appBar: AppBar(
            backgroundColor: ColorManager.backgroundColor,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: ColorManager.whiteColor,
                )),
            title: Text(
              "Detection",
              style: TextStyle(color: ColorManager.whiteColor),
            )),
        body: Center(
          child: _chewieController != null &&
                  _chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: _chewieController!)
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
