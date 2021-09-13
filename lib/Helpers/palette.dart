import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xffff2626, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffff2626), //10%
      100: const Color(0xffe62222), //20%
      200: const Color(0xffcc1e1e), //30%
      300: const Color(0xffb31b1b), //40%
      400: const Color(0xff991717), //50%
      500: const Color(0xff801313), //60%
      600: const Color(0xff4c0b0b), //70%
      700: const Color(0xff330808), //80%
      800: const Color(0xff190404), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
