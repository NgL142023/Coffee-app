import 'package:flutter/material.dart';

class AppLayout {
  static double getScreenHeight() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size
        .height;
  }

  static double getScreenWidth() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  }

  static double getHeight(double pixels) {
    double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static double getWidth(double pixels) {
    double y = getScreenWidth() / pixels;
    return getScreenWidth() / y;
  }
}
