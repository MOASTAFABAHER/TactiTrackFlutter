import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'package:tacti_track/models/view/Screens/History_detected_screen.dart';
import 'package:tacti_track/models/view/Screens/upload_screen.dart';
import 'package:tacti_track/managers/color_manager.dart';

class HomeScreenLayout extends StatefulWidget {
  const HomeScreenLayout({super.key});

  @override
  State<HomeScreenLayout> createState() => _HomeScreenLayoutState();
}

class _HomeScreenLayoutState extends State<HomeScreenLayout> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screens = [const UploadScreen(), const HistoryDetectedScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: ColorManager.backgroundColor,
        selectedItemColor: ColorManager.greenColor,
        unselectedItemColor: ColorManager.whiteColor,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/analytics.png',
                height: 15.h,
                color: _selectedIndex == 0
                    ? ColorManager.greenColor
                    : ColorManager.whiteColor,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/now-in-stock.png',
                height: 15.h,
                color: _selectedIndex == 1
                    ? ColorManager.greenColor
                    : ColorManager.whiteColor,
              ),
              label: 'Detected Videos'),
        ],
      ),
      backgroundColor: ColorManager.backgroundColor,
      body: screens[_selectedIndex],
    );
  }
}
