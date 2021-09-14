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
    return BaseWidget(
      children: [
        Text('Compare Pokemon Page',
            style: Theme.of(context).textTheme.headline5!),
        Text('on testing', style: Theme.of(context).textTheme.headline4!),
      ],
    );
  }
}
