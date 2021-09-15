import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/raisedGradientButton.dart';

class CompareScreen extends StatefulWidget {
  CompareScreen({Key? key}) : super(key: key);

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.width / 4;
    return BaseWidget(
      children: [
        Text('Compare Pokemon Page',
            style: Theme.of(context).textTheme.headline4!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('Name', style: Theme.of(context).textTheme.headline5),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/images/1.png', width: imageSize),
                  )
                ],
              ),
              Column(
                children: [
                  Text('Name', style: Theme.of(context).textTheme.headline5),
                  ElevatedButton(
                    onPressed: () {},
                    child: Image.asset('assets/images/2.png', width: imageSize),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(right: imageSize / 2 - 20),
          child: RaisedGradientButton(
            child: Text(
              'Compare pokemon!',
              style: TextStyle(color: Colors.white),
            ),
            width: 150,
            height: 30,
            gradient: LinearGradient(
              colors: <Color>[Colors.red[700]!, Colors.red[400]!],
            ),
            onPressed: () {
              print('button clicked');
            },
          ),
        ),
      ],
    );
  }
}
