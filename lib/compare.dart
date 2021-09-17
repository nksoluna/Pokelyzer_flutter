import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/searchWidget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

class CompareWidgetTest extends StatefulWidget {
  @override
  CompareWidgetTestState createState() => CompareWidgetTestState();
}

class CompareWidgetTestState extends State<CompareWidgetTest> {
  Pokemon? selectedPokemon1;
  Pokemon? selectedPokemon2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            selectingPokemon(context);
          },
          child: selectedPokemon1 == null
              ? Text("no pokemon")
              : Text(selectedPokemon1!.name),
        ),
        ElevatedButton(
          onPressed: () {},
          child: selectedPokemon2 == null
              ? Text("no pokemon")
              : Text(selectedPokemon2!.name),
        )
      ],
    );
  }

  // might be value instead of void
  void selectingPokemon(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchWidget()),
    );
  }
}
