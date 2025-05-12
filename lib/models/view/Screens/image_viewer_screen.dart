import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Key _imageKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    // Delayed orientation change to avoid rendering issues
    Future.delayed(Duration.zero, () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    });
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        body: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                key: _imageKey,
                width: double.infinity,
                imageUrl: widget.imageUrl,
                httpHeaders: const {
                  'Accept': 'image/*',
                  'Connection': 'keep-alive',
                },
                maxWidthDiskCache: 1024,
                cacheKey: widget.imageUrl,
                imageBuilder: (context, imageProvider) =>
                    Image(image: imageProvider, fit: BoxFit.contain),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.greenColor,
                  ),
                ),
                errorWidget: (context, url, error) {
                  debugPrint('Failed to load image: $url\nError: $error');
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        _imageKey = UniqueKey();
                        setState(() {}); // This forces the image to rebuild
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.error, size: 28.sp, color: Colors.red),
                          SizedBox(height: 12.h),
                          const Text(
                            'Failed to load image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                },
                icon: Icon(Icons.arrow_back, color: ColorManager.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
