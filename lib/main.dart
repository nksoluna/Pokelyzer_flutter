import 'package:flutter/material.dart';
import 'Helpers/palette.dart';
import 'Screens/Compare/compare.dart';
import 'Screens/Home/home.dart';
import 'pokelyzer.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Color primaryColor = const Color(0xFFff2626);
  Color secondaryColor = const Color(0xFFbd1616);
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
          bodyText2: TextStyle(fontSize: 15.0, color: Color(0xFF000000)),
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/compare': (context) => CompareScreen(),
      },
    );
  }
}
