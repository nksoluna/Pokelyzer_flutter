import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(children: [Center(child: Text('Home Screen'))]);
  }
}
