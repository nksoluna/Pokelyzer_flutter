import 'package:flutter/widgets.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:pokelyzer/searchFunction.dart';

class SearchWidget extends StatefulWidget {
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  List<String> allTypeString = getAllTypeInString();
  List<Pokemon> allPokemon = [];
  List<Type> allType = [];
  List<Pokemon> selectedPokemon = [];
  List<bool> selectedTypeArray = [];
  late TextEditingController searchIndexController;
  late TextEditingController searchNameController;
  @override
  void initState() {
    super.initState();
    searchIndexController = TextEditingController();
    searchNameController = TextEditingController();
    for (int i = 0; i < 18; i++) {
      selectedTypeArray.add(false);
    }
    readData();
  }

  @override
  void dispose() {
    super.dispose();
    searchIndexController.dispose();
    searchNameController.dispose();
  }

  Future<void> readData() async {
    allPokemon = await readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
    selectedPokemon = allPokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: searchIndexController,
              decoration: InputDecoration(labelText: 'Enter Index'),
            ),
            TextField(
              controller: searchNameController,
              decoration: InputDecoration(labelText: 'Enter Pokemon Name'),
            ),
            Container(
              child: Expanded(
                  child: ListView.builder(
                      itemCount: selectedTypeArray.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(allTypeString[index]),
                            tileColor: selectedTypeArray[index]
                                ? Colors.redAccent
                                : Colors.white,
                            onTap: () {
                              setState(() {
                                selectedTypeArray[index] =
                                    !selectedTypeArray[index];
                              });
                            },
                          ),
                        );
                      })),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedPokemon = searchPokemon(
                        searchIndexController.text,
                        searchNameController.text,
                        selectedTypeArray,
                        allPokemon,
                        allType);
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(selectedPokemon)));
                },
                child: Text("Search")),
          ],
        ),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final List<Pokemon> selectedPokemon;
  const SearchResult(this.selectedPokemon);

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 100),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back")),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.selectedPokemon.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context, widget.selectedPokemon[index]);
                      },
                      title: Text(widget.selectedPokemon[index].name),
                    ));
                  }))
        ],
      ),
    );
  }
}
