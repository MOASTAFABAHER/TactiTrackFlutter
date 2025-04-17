import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:tacti_track/managers/color_manager.dart';
import 'package:tacti_track/models/view/components/window_tile_bar/window_buttons.dart';

class windowTitleBarCustom extends StatelessWidget {
  const windowTitleBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: ColorManager.backgroundColor,
              child: MoveWindow(),
            ),
          ),
          const WindowButtons()
        ],
      ),
    );
  }
}
