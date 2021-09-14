import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:pokelyzer/search.dart';

class Pokelyzer extends StatefulWidget {
  @override
  PokelyzerState createState() => PokelyzerState();
}

class PokelyzerState extends State<Pokelyzer> {
  List allPokemon = [];
  List allType = [];
  List selectedPokemons = [];
  int _currentindex = 4;

  late TextEditingController searchNameController;
  late TextEditingController searchIndexController;

  @override
  void initState() {
    super.initState();
    searchNameController = TextEditingController();
    searchIndexController = TextEditingController();
  }

  Future<bool> readData() async {
    allPokemon = await readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
    selectedPokemons = allPokemon;
    return true;
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
              FutureBuilder(
                future: readData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: selectedPokemons.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                leading: Text(
                                    selectedPokemons[index].index.toString()),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(selectedPokemons[index].name),
                                    Text("total move: " +
                                        selectedPokemons[index]
                                            .moves
                                            .length
                                            .toString())
                                  ],
                                ),
                                subtitle: selectedPokemons[index]
                                            .types
                                            .length ==
                                        1
                                    ? Text(selectedPokemons[index].types[0])
                                    : Row(
                                        children: [
                                          Text(
                                              selectedPokemons[index].types[0]),
                                          Text("  "),
                                          Text(selectedPokemons[index].types[1])
                                        ],
                                      )),
                          );
                        }),
                  );
                },
              )
            ],
          ),
        ),
        Center(
          child: Column(
            children: [TextField(), TextField()],
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
          });
        },
      ),
    );
  }
}
