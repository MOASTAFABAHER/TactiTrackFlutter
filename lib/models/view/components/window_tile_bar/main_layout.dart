import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tacti_track/models/view/components/window_tile_bar/window_tile_bar.dart'
    as platform;

import 'window_tile_bar.dart';

class MainLayout extends StatelessWidget {
  Widget child;
  MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Platform.isWindows || Platform.isLinux || Platform.isMacOS
            ? const windowTitleBarCustom()
            : const SizedBox(),
        Expanded(child: child)
      ],
    );
  }
}
