import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_circle.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/CustomWidgets/searchWidget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

class CompareScreen extends StatefulWidget {
  CompareScreen({Key? key}) : super(key: key);

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  Pokemon? selectedPokemon1;
  Pokemon? selectedPokemon2;
  List<Pokemon> allPokemon = [];
  List<Type> allType = [];
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    allPokemon = await PokemonsRepo().readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
  }

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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Column(
              children: [
                (selectedPokemon1 == null)
                    ? Text('Name', style: Theme.of(context).textTheme.headline5)
                    : Text(selectedPokemon1!.name,
                        style: Theme.of(context).textTheme.headline5),
                PokemonSelectorWidget(
                  width: imageSize,
                  imagePath: selectedPokemon1 == null
                      ? 'assets/images/pokemons/201.png'
                      : ('assets/images/pokemons/' +
                          selectedPokemon1!.index.toString() +
                          ".png"),
                  onTap: () {
                    selectingPokemon(context, 1);
                  },
                ),
                (selectedPokemon1 != null)
                    ? Row(
                        children: [
                          selectedPokemon1!.types.length == 2
                              ? Container(
                                  child: Row(
                                    children: [
                                      Text(selectedPokemon1!.types[0]),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(selectedPokemon1!.types[1])
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Text(selectedPokemon1!.types[0]),
                                )
                        ],
                      )
                    : SizedBox()
              ],
            ),
            Column(
              children: [
                (selectedPokemon2 == null)
                    ? Text('Name', style: Theme.of(context).textTheme.headline5)
                    : Text(selectedPokemon2!.name,
                        style: Theme.of(context).textTheme.headline5),
                PokemonSelectorWidget(
                  width: imageSize,
                  imagePath: selectedPokemon2 == null
                      ? 'assets/images/pokemons/201.png'
                      : ('assets/images/pokemons/' +
                          selectedPokemon2!.index.toString() +
                          ".png"),
                  onTap: () {
                    selectingPokemon(context, 2);
                  },
                ),
                (selectedPokemon2 != null)
                    ? Row(
                        children: [
                          selectedPokemon2!.types.length == 2
                              ? Container(
                                  child: Row(
                                    children: [
                                      Text(selectedPokemon2!.types[0]),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text(selectedPokemon2!.types[1])
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Text(selectedPokemon2!.types[0]),
                                )
                        ],
                      )
                    : SizedBox()
              ],
            ),
          ]),
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

  void selectingPokemon(BuildContext context, int side) async {
    Pokemon? result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchWidget(allPokemon, allType)),
    );
    setState(() {
      if (side == 1)
        selectedPokemon1 = result;
      else if (side == 2) selectedPokemon2 = result;
    });
  }
}
