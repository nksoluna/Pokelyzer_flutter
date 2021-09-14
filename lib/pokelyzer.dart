import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class Pokelyzer extends StatefulWidget {
  @override
  PokelyzerState createState() => PokelyzerState();
}

class PokelyzerState extends State<Pokelyzer> {
  bool isInitialLoad = false;
  List pkmnItems = [];
  List typeItems = [];
  int _currentindex = 0;
  List selectedPokemon = [];
  var selectedType = [];
  late TextEditingController searchNameController;
  late TextEditingController searchIndexController;

  @override
  void initState() {
    super.initState();
    searchNameController = TextEditingController();
    searchIndexController = TextEditingController();
  }

  // แก้
  Future<void> readJson() async {
    // load from assets/pokemons.json
    final String pkmnResponse = await rootBundle.loadString('pokemons.json');
    final String typeResponse = await rootBundle.loadString('types.json');
    final pkmnData = await json.decode(pkmnResponse);
    final typeData = await json.decode(typeResponse);
    for (int i = 0; i < 18; i++) {
      selectedType.add(false);
    }
    setState(() {
      pkmnItems = pkmnData;
      selectedPokemon = pkmnData;
      typeItems = typeData;
    });
  }

  // แก้
  List<dynamic> searchWithType() {
    var selectedPokemons1 = [];
    var selectedPokemons2 = [];
    for (int i = 0; i < 18; i++) {
      if (selectedType[i]) {
        for (int j = 0; j < pkmnItems.length; j++) {
          if (pkmnItems[j]["type"]
              .any((type) => type == typeItems[i]["name"].toLowerCase())) {
            selectedPokemons1.add(pkmnItems[j]);
          }
        }
        for (int k = i + 1; k < 18; k++) {
          if (selectedType[k]) {
            for (int l = 0; l < selectedPokemons1.length; l++) {
              if (selectedPokemons1[l]["type"]
                  .any((type) => type == typeItems[k]["name"].toLowerCase())) {
                selectedPokemons2.add(selectedPokemons1[l]);
              }
            }
            break;
          }
        }
        if (selectedPokemons2.isNotEmpty) return selectedPokemons2;
      }
    }

    return selectedPokemons1;
  }

  // แก้
  List<dynamic> searchWithIndex(int i) {
    var selectedPokemon = [];

    selectedPokemon
        .add(pkmnItems.firstWhere((element) => element["index"] == i));
    return selectedPokemon;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentindex, children: [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pokedex Here'),
          ],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Compare Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Team Builder Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Favourite Here')],
        )),
        Center(
          child: Column(
            children: [
              selectedPokemon.length > 0
                  // แก้เป็น StreamBuilder ให้โหลดข้อมูลตาม Async
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: selectedPokemon.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              leading: Text(
                                  selectedPokemon[index]["index"].toString()),
                              title: Text(selectedPokemon[index]["name"]),
                              subtitle: selectedPokemon[index]["type"].length ==
                                      1
                                  ? Row(
                                      children: [
                                        Text(selectedPokemon[index]["type"][0])
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Text(selectedPokemon[index]["type"][0]),
                                        Text("    "),
                                        Text(selectedPokemon[index]["type"][1])
                                      ],
                                    ),
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              TextField(
                controller: searchIndexController,
                decoration: InputDecoration(labelText: "Enter Index"),
              ),
              TextField(
                controller: searchNameController,
                decoration: InputDecoration(labelText: "Enter Pokemon Name"),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedPokemon = searchWithType();
                      /*
                      selectedPokemon = searchWithIndex(
                          int.parse(searchIndexController.text));
                      */
                    });
                  },
                  child: Text("Search")),
              Expanded(
                child: ListView.builder(
                    itemCount: typeItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          tileColor: selectedType[index]
                              ? Colors.blueGrey
                              : Colors.white,
                          title: Text(typeItems[index]["name"]),
                          onTap: () {
                            setState(() {
                              selectedType[index] = !selectedType[index];
                            });
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.data_usage),
              label: "Pokedex",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Compare"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Team Builder"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: "Search Testing"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: "Search Testing 2"),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
            if (!isInitialLoad) readJson();
            isInitialLoad = true;
          });
        },
      ),
    );
  }
}
