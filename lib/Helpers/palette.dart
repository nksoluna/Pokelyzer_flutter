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
  List<Color> getAllTypeColor() {
    return [
      Color(0xffada595), // normal
      Color(0xfff4533a), // fire
      Color(0xff409efc), // water
      Color(0xfffec543), // electric
      Color(0xff7ecc59), // grass
      Color(0xff60cee5), // ice
      Color(0xffa3523d), // fighting
      Color(0xffb45da4), // poison
      Color(0xffbc9b50), // ground
      Color(0xff9daff5), // flying
      Color(0xfffd75a5), // psychic
      Color(0xffadbb33), // bug
      Color(0xffbca45f), // rock
      Color(0xff6365b3), // ghost
      Color(0xff7866db), // dragon
      Color(0xff725a4a), // dark
      Color(0xffadadc5), // steel
      Color(0xfff6b7f6), // fairy
    ];
  }

  Color getSelectedTypeColor(String pokemonType, List<String> allTypeString) {
    List<Color> typeColors = getAllTypeColor();
    for (int i = 0; i < 18; i++) {
      if (pokemonType == allTypeString[i]) return typeColors[i];
    }
    return typeColors[0];
  }
}
