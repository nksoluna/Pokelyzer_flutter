import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_circle.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/CustomWidgets/searchWidget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/Helpers/analyzing.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TeamBuilderScreen extends StatefulWidget {
  @override
  TeamBuilderScreenState createState() => TeamBuilderScreenState();
}

class TeamBuilderScreenState extends State<TeamBuilderScreen> {
  List<Pokemon?> selectedPokemon = List.filled(6, null);
  List<Pokemon> allPokemon = [];
  List<Type> allType = [];
  List<int> totalWeakness = [];
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
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.width / 4;
    return Stack(
      children: <Widget>[
        BaseWidget(
          children: [
            Text('Team Strength/Weakness Analyzing',
                style: Theme.of(context).textTheme.headline4!.merge(
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => PokemonSelectorWidget(
                    selectedPokemon: selectedPokemon[index],
                    width: imageSize,
                    onTap: () {
                      selectingPokemon(context, index);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => PokemonSelectorWidget(
                    selectedPokemon: selectedPokemon[index + 3],
                    width: imageSize,
                    onTap: () {
                      selectingPokemon(context, index + 3);
                    },
                  ),
                ),
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
                  // Analyzing().AnalyzingWeakness(
                  //     selectedPokemon1,
                  //     selectedPokemon2,
                  //     selectedPokemon3,
                  //     selectedPokemon4,
                  //     selectedPokemon5,
                  //     selectedPokemon6,
                  //     allPokemon,
                  //     allType);
                },
              ),
            ),
          ],
        ),
        SlidingUpPanel(
          borderRadius: radius,
          panel: Center(
            child: Text("This is sliding up panel"),
          ),
        )
      ],
    );
  }

  void selectingPokemon(BuildContext context, int index) async {
    Pokemon? result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchWidget(allPokemon, allType)),
    );
    setState(() {
      if (result != null) {
        setState(() {
          selectedPokemon[index] = result;
        });
      }
    });
  }
}
