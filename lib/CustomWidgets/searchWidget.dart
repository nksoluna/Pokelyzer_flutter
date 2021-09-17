import 'package:flutter/widgets.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/searchFunction.dart';

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
    var repo = PokemonsRepo();
    allPokemon = await repo.readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
    selectedPokemon = allPokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 0, top: 5),
                child: RawMaterialButton(
                  fillColor: Colors.red[400],
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "<",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  padding: EdgeInsets.all(10.0),
                  shape: CircleBorder(),
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 300,
              child: TextField(
                controller: searchIndexController,
                decoration: InputDecoration(labelText: 'Enter Index'),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                controller: searchNameController,
                decoration: InputDecoration(labelText: 'Enter Pokemon Name'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 20),
              width: 300,
              child: Text(
                "Select Types( Up to 2 type )",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Container(
                child: Expanded(
                    child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 35,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                color: selectedTypeArray[index]
                                    ? Colors.redAccent
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedTypeArray[index] =
                                          !selectedTypeArray[index];
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      allTypeString[index],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 9,
                        itemBuilder: (context, index) {
                          return Container(
                              height: 35,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                color: selectedTypeArray[index + 9]
                                    ? Colors.redAccent
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.red, width: 1),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedTypeArray[index + 9] =
                                          !selectedTypeArray[index + 9];
                                    });
                                  },
                                  child: Center(
                                    child: Text(
                                      allTypeString[index + 9],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ));
                        }),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
              ],
            ))),
            Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(bottom: 10, right: 10),
                child: RaisedGradientButton(
                  height: 40,
                  width: 100,
                  gradient: LinearGradient(
                    colors: <Color>[Colors.red[700]!, Colors.red[400]!],
                  ),
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
                            builder: (context) =>
                                SearchResult(selectedPokemon)));
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ))
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
