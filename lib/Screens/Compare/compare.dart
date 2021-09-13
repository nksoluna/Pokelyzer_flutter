import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/drawer.dart';

class CompareScreen extends StatefulWidget {
  CompareScreen({Key? key}) : super(key: key);

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(child: Text('Compare Screen')),
                  DrawerButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}