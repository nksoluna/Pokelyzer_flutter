import 'package:flutter/material.dart';
import 'package:pokelyzer/Screens/favorites/favorites.dart';
import 'Helpers/palette.dart';
import 'Screens/Compare/compare.dart';
import 'Screens/Home/home.dart';
import 'Screens/TeamBuilder/teamBuilder.dart';
import 'Screens/pokemonall/pokemon_all.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

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
      initialRoute: '/compare',
      routes: {
        '/home': (context) => AllpokemonScreen(),
        '/compare': (context) => CompareScreen(),
        '/team_builder': (context) => TeamBuilderScreen(),
        '/favorite': (context) => FavoriteScreen(),
      },
    );
  }
}
