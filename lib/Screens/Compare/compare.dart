import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_circle.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';

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
        Text('Compare Pokemon',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .merge(TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Name', style: Theme.of(context).textTheme.headline5),
                  PokemonSelectorWidget(
                    width: imageSize,
                    imagePath: 'assets/images/pokemons/134.png',
                    onTap: () {
                      print('1 Tapped!');
                    },
                  ),
                  Text('types'),
                ],
              ),
              Column(
                children: [
                  Text('Name', style: Theme.of(context).textTheme.headline5),
                  PokemonSelectorWidget(
                    width: imageSize,
                    imagePath: 'assets/images/pokemons/500.png',
                    onTap: () {
                      print('2 Tapped!');
                    },
                  ),
                  Text('types'),
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
              'Compare Pokemon!',
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
