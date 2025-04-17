import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tacti_track/domain/dio_helper.dart';
import 'package:tacti_track/domain/local/sp__keys.dart';
import 'package:tacti_track/domain/local/sp_helper.dart';
import 'package:tacti_track/models/view/Screens/image_viewer_screen.dart';
import 'package:tacti_track/utils/app_navigator.dart';

import '../../../models/view/Screens/video_player_screen.dart';

part 'TactiTrack_state.dart';

class TactiTrackCubit extends Cubit<TactiTrackState> {
  TactiTrackCubit() : super(TactiTrackInitial());

  static TactiTrackCubit get(context) => BlocProvider.of(context);
  String? videoUrl;
  String? imageUrl;
  // ignore: prefer_typing_uninitialized_variables
  var responseData;
  Future<void> pickAndUpload(context, {required bool isVideo}) async {
    File? selectedFile;

    try {
      if (isVideo) {
        // Pick video for all platforms
        final picked =
            await FilePicker.platform.pickFiles(type: FileType.video);
        if (picked != null && picked.files.isNotEmpty) {
          selectedFile = File(picked.files.first.path!);
        }
      } else {
        if (kIsWeb ||
            Platform.isWindows ||
            Platform.isMacOS ||
            Platform.isLinux) {
          // Use FilePicker for image on desktop/web
          final picked =
              await FilePicker.platform.pickFiles(type: FileType.image);
          if (picked != null && picked.files.isNotEmpty) {
            selectedFile = File(picked.files.first.path!);
          }
        } else {
          // Use ImagePicker for image on mobile
          final ImagePicker picker = ImagePicker();
          final XFile? image =
              await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            selectedFile = File(image.path);
          }
        }
      }

      if (selectedFile == null) {
        log("No file selected");
        return;
      }

      // Prepare FormData
      FormData formData = FormData.fromMap({
        isVideo ? 'video' : 'image':
            await MultipartFile.fromFile(selectedFile.path),
      });

      emit(isVideo
          ? TactiTrackUploadVideoLoadingState()
          : TactiTrackUploadImageLoadingState());

      await DioHelper.uploadVideo(
        url: isVideo ? '/analyze' : '/analyze-image',
        formData: formData,
      ).then((data) async {
        String responseData = utf8.decode(data.data);
        String? mediaUrl =
            jsonDecode(responseData)[isVideo ? 'video_url' : 'image_url'];

        bool isEmulator = await _isDeviceEmulator();
        if (isEmulator && mediaUrl != null) {
          mediaUrl = mediaUrl.replaceFirst('127.0.0.1', '10.0.2.2');
        }

        if (isVideo) {
          videoUrl = mediaUrl;
          SharedPrefrenceHelper.addStringToList(
              key: SharedPreferencesKeys.videoPaths, value: videoUrl!);
          AppNavigator.appNavigator(
              context, VideoPlayerScreen(videoUrl: videoUrl!));
          emit(TactiTrackUploadVideoSuccessState());
        } else {
          imageUrl = mediaUrl;
          SharedPrefrenceHelper.addStringToList(
              key: SharedPreferencesKeys.imagesPath, value: imageUrl!);
          log(imageUrl.toString());
          AppNavigator.appNavigator(
              context,
              ImageViewerScreen(
                imageUrl: imageUrl!,
              ));
          emit(TactiTrackUploadImageSuccessState());
        }

        log(mediaUrl.toString());
        log(responseData.toString());
      }).catchError((e) {
        emit(isVideo
            ? TactiTrackUploadVideoErrorState()
            : TactiTrackUploadImageErrorState());
        log(e.toString());
      });
    } catch (e) {
      log("Error during file picking: $e");
    }
  }

  Future<bool> _isDeviceEmulator() async {
    if (kIsWeb) return false;

    try {
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        return !androidInfo.isPhysicalDevice;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        return !iosInfo.isPhysicalDevice;
      }
    } catch (e) {
      log('Emulator detection failed: $e');
    }
    return false;
  }
}
