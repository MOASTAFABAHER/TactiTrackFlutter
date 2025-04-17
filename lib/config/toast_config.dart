import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:tacti_track/managers/color_manager.dart';

import '../enums/toast_status.dart';

class ToastConfig {
  static showToast({
    required String msg,
    required ToastStates toastStates,
  }) =>
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0,
      );
}

Color chooseToastColor(ToastStates state) {
  late Color color;
  switch (state) {
    case ToastStates.Success:
      color = ColorManager.greenColor;
      break;
    case ToastStates.Error:
      color = Colors.red;
      break;
    case ToastStates.Warning:
      color = Colors.orange;
      break;
  }

  return color;
}
