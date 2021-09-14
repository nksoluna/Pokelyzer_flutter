import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';

class CompareScreen extends StatefulWidget {
  CompareScreen({Key? key}) : super(key: key);

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget(child: Center(child: Text('Compare Screen')));
  }
}
