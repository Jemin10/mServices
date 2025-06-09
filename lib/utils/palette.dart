import 'dart:math';

import 'package:flutter/material.dart';

class Palette {
  static Color primary = const Color(0xFF283891);
  static Color secondary = const Color(0xFFE5EAFF);
  static Color text = const Color(0xFF161616);
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF000000);
  static Color green = const Color(0xFF52B46B);
  static Color red = const Color(0xFFF54343);
  static Color grey = const Color(0xFFD8D8D8);
  static Color greyText = const Color(0xFF858585);
  static Color lightGrey = const Color(0xFFF3F3F3);
  static Color hintGrey = const Color(0xFFABABAB);
  static Color yellow = const Color(0xFFFFC107);
  static Color transparent = Colors.transparent;

  ///
  static MaterialColor generateMaterialColor() {
    return MaterialColor(primary.hashCode, {
      50: tintColor(primary, 0.9),
      100: tintColor(primary, 0.8),
      200: tintColor(primary, 0.6),
      300: tintColor(primary, 0.4),
      400: tintColor(primary, 0.2),
      500: primary,
      600: shadeColor(primary, 0.1),
      700: shadeColor(primary, 0.2),
      800: shadeColor(primary, 0.3),
      900: shadeColor(primary, 0.4),
    });
  }

  static int tintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static Color tintColor(Color color, double factor) {
    return Color.fromARGB(
      _extractAlpha(color),
      _adjustTintValue(_extractRed(color), factor),
      _adjustTintValue(_extractGreen(color), factor),
      _adjustTintValue(_extractBlue(color), factor),
    );
  }

  static int shadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static Color shadeColor(Color color, double factor) {
    return Color.fromARGB(
      _extractAlpha(color),
      _adjustShadeValue(_extractRed(color), factor),
      _adjustShadeValue(_extractGreen(color), factor),
      _adjustShadeValue(_extractBlue(color), factor),
    );
  }

  static int _extractAlpha(Color color) => (color.hashCode >> 24) & 0xFF;

  static int _adjustTintValue(int value, double factor) {
    return max(0, min((value + ((255 - value) * factor)).round(), 255));
  }

  static int _adjustShadeValue(int value, double factor) {
    return max(0, min(value - (value * factor).round(), 255));
  }

  static int _extractRed(Color color) => (color.hashCode >> 16) & 0xFF;

  static int _extractGreen(Color color) => (color.hashCode >> 8) & 0xFF;

  static int _extractBlue(Color color) => color.hashCode & 0xFF;
}
