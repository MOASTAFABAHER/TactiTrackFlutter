import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tacti_track/app_root/tacti_track.dart';
import 'package:tacti_track/domain/dio_helper.dart';

import 'package:fvp/fvp.dart' as fvp;
import 'package:tacti_track/domain/local/sp_helper.dart';

void main() async {
  fvp.registerWith();
  await SharedPrefrenceHelper.init();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    doWhenWindowReady(() {
      const initialSize = Size(1000, 690);
      appWindow.minSize = initialSize;
      appWindow.size = initialSize;
      appWindow.alignment = Alignment.center;
      appWindow.show();
    });
  }
  if (Platform.isAndroid || Platform.isIOS) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
  runApp(const TactiTrack());
  DioHelper.init();
}
