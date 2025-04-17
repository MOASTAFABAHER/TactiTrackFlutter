import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tacti_track/managers/color_manager.dart';

class ImageViewerScreen extends StatefulWidget {
  final String imageUrl;
  final int maxRetries;

  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
    this.maxRetries = 3,
  });

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          imageUrl: widget.imageUrl,
          httpHeaders: const {
            'Accept': 'image/*',
            'Connection': 'keep-alive',
          },
          maxWidthDiskCache: 1024, // Prevent cache issues
          cacheKey: widget.imageUrl, // Unique cache key
          imageBuilder: (context, imageProvider) => Image(image: imageProvider),
          placeholder: (context, url) => Scaffold(
            backgroundColor: ColorManager.backgroundColor,
            body: Center(
                child: CircularProgressIndicator(
              color: ColorManager.greenColor,
            )),
          ),
          errorWidget: (context, url, error) {
            debugPrint('Failed to load image: $url\nError: $error');
            return const Icon(Icons.error);
          },
        ),
        IconButton(
            onPressed: () {
              Navigator.pop(context);
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ]);
            },
            icon: Icon(Icons.arrow_back, color: ColorManager.whiteColor))
      ],
    );
  }
}
