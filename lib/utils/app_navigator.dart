import 'package:flutter/material.dart';

class AppNavigator {
  static void printt() {
    print('I am Printing');
  }

  static Future<T?> appNavigator<T>(
    BuildContext context,
    Widget screen, {
    bool isFinished = false,
  }) {
    if (isFinished) {
      return Navigator.pushReplacement<T, T>(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      return Navigator.push<T>(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget screen,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  static Future<T?> pushNamed<T>(BuildContext context, String routeName) {
    return Navigator.pushNamed<T>(context, routeName);
  }

  static Future<T?> pushReplacementNamed<T>(
      BuildContext context, String routeName) {
    return Navigator.pushReplacementNamed<T, T>(context, routeName);
  }
}
