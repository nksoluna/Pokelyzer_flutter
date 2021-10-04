import 'package:flutter/material.dart';
import 'package:pokelyzer/models/pokemon.dart';

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

  Color getColorFromPokemonType(Pokemon pokemon) {
    Color typeColor = Color(0xFFFFFFFF);
    var types = pokemon.types[0];
    switch (types) {
      case 'normal':
        typeColor = Color(0xFFA8A878);
        break;
      case 'fire':
        typeColor = Color(0xFFF08030);
        break;
      case 'water':
        typeColor = Color(0xFF6890F0);
        break;
      case 'grass':
        typeColor = Color(0xFF78C850);
        break;
      case 'electric':
        typeColor = Color(0xFFF8D030);
        break;
      case 'ice':
        typeColor = Color(0xFF98D8D8);
        break;
      case 'fighting':
        typeColor = Color(0xFFC03028);
        break;
      case 'poison':
        typeColor = Color(0xFFA040A0);
        break;
      case 'ground':
        typeColor = Color(0xFFE0C068);
        break;
      case 'flying':
        typeColor = Color(0xFFA890F0);
        break;
      case 'psychic':
        typeColor = Color(0xFFF85888);
        break;
      case 'bug':
        typeColor = Color(0xFFA8B820);
        break;
      case 'rock':
        typeColor = Color(0xFFB8A038);
        break;
      case 'ghost':
        typeColor = Color(0xFF705898);
        break;
      case 'dark':
        typeColor = Color(0xFF705848);
        break;
      case 'dragon':
        typeColor = Color(0xFF7038F8);
        break;
      case 'steel':
        typeColor = Color(0xFFADADC5);
        break;
      case 'fairy':
        typeColor = Color(0xFFEE99AC);
        break;
    }
    return typeColor;
  }
}
