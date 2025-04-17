import 'package:flutter/material.dart';

class OnBoarding1Screen extends StatelessWidget {
  const OnBoarding1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/tacti_track.png'),
        ],
      ),
    );
  }
}
