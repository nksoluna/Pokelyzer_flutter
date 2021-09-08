import 'package:flutter/material.dart';
import 'pokelyzer.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LastTime Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Pokelyzer(),
    );
  }
}
