import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/searchWidget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:pokelyzer/compare.dart';
import 'package:pokelyzer/searchFunction.dart';

class Pokelyzer extends StatefulWidget {
  @override
  PokelyzerState createState() => PokelyzerState();
}

class PokelyzerState extends State<Pokelyzer> {
  List<Pokemon> allPokemon = [];
  List<Type> allType = [];
  List<Pokemon> selectedPokemons = [];
  List<bool> selectedType = [];
  int _currentindex = 0;

  late TextEditingController searchNameController;
  late TextEditingController searchIndexController;

  @override
  void initState() {
    super.initState();
    searchNameController = TextEditingController();
    searchIndexController = TextEditingController();
    for (int i = 0; i < 18; i++) {
      selectedType.add(false);
    }
    setState(() {
      readData();
    });
  }

  @override
  void dispose() {
    searchNameController.dispose();
    searchIndexController.dispose();
    super.dispose();
  }

  Future<void> readData() async {
    allPokemon = await readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
    selectedPokemons = allPokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentindex, children: [
        Center(child: SearchWidget()),
        Center(child: CompareWidgetTest()),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: "Search Testing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: "Search Testing 2"),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
