import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [Center(child: Text('Home Screen')), DrawerButton()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
