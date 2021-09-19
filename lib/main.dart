<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:pokelyzer/pokemon_info/pokemon_info.dart';
import 'Helpers/palette.dart';
import 'Screens/Compare/compare.dart';
import 'Screens/Home/home.dart';
import 'Screens/TeamBuilder/teamBuilder.dart';
import 'Screens/pokemonall/pokemon_all.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = const Color(0xFFff2626);
  final Color secondaryColor = const Color(0xFFbd1616);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastTime Tracker App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        primarySwatch: Palette.kToDark,
        disabledColor: Colors.grey[600],
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, color: Color(0xFF000000)),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => AllpokemonScreen(),
        '/compare': (context) => CompareScreen(),
        '/character': (context) => PokemonInfoScreen(),
        '/team_builder': (context) => TeamBuilderScreen(),
      },
    );
  }
}
=======
import 'package:flutter/material.dart';
import 'package:pokelyzer/Screens/pokemonall/pokemon_all.dart';
import 'package:pokelyzer/pokemon_info/pokemon_info.dart';
import 'Helpers/palette.dart';
import 'Screens/Compare/compare.dart';
import 'Screens/Home/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = const Color(0xFFff2626);
  final Color secondaryColor = const Color(0xFFbd1616);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastTime Tracker App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        primarySwatch: Palette.kToDark,
        disabledColor: Colors.grey[600],
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, color: Color(0xFF000000)),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => AllpokemonScreen(),
        '/compare': (context) => CompareScreen(),
        '/character': (context) => PokemonInfoScreen(),
      },
    );
  }
}
>>>>>>> c5e2df6fb511d1fb5b9bac0c2fa686efbcb4c37a
