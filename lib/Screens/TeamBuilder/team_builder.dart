import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_teambuilder.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/CustomWidgets/search_widget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/Helpers/analyzing.dart';
import 'package:pokelyzer/Screens/TeamBuilder/properties_show.dart';
import 'package:pokelyzer/models/type_pokemon.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TeamBuilderScreen extends StatefulWidget {
  @override
  TeamBuilderScreenState createState() => TeamBuilderScreenState();
}

class TeamBuilderScreenState extends State<TeamBuilderScreen> {
  List<Pokemon?> selectedPokemon = List.filled(6, null);
  List<Pokemon> allPokemon = [];
  List<TypePokemon> allType = [];
  // weakness & strength[weakness is - , strength is + in list]  another is immune
  List<List<int>> teamProperties = List.filled(2, List.filled(18, 0));
  // index 0 = weakness ,1 = strength ,2 = immune
  List<List<String>> activeTypeStringList = List.filled(3, []);
  List<List<int>> activeTypeValueList = List.filled(3, []);

  final scrollController = ScrollController();
  final panelController = PanelController();
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    final box = Hive.box<Pokemon>('allpokemon');
    allPokemon.addAll(box.values);
    final typebox = Hive.box<TypePokemon>('alltype');
    allType.addAll(typebox.values);
  }

  @override
  Widget build(BuildContext context) {
    //double selectorWidth = MediaQuery.of(context).size.width / 4;
    double selectorWidth = 100.00;
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.width / 4.5;
    return Stack(
      children: <Widget>[
        BaseWidget(
          panelController: panelController,
          tabBar: ["Weakness", "Strength", "Immune"],
          panelRadius: 24,
          panelBody: [
            PropertiesShow(
                activeTypeStringList[0], activeTypeValueList[0], "Weakness"),
            PropertiesShow(
                activeTypeStringList[1], activeTypeValueList[1], "Strength"),
            PropertiesShow(
                activeTypeStringList[2], activeTypeValueList[2], "Immune")
          ],
          children: [
            Text('Team Strength/Weakness Analyzing',
                style: Theme.of(context).textTheme.headline4!.merge(
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: selectorWidth,
                      child: PokemonSelectorBuilderWidget(
                        selectedPokemon: selectedPokemon[0],
                        width: imageSize,
                        onTap: () {
                          selectingPokemon(context, 0);
                        },
                      ),
                    ),
                    Container(
                      width: selectorWidth,
                      child: PokemonSelectorBuilderWidget(
                        selectedPokemon: selectedPokemon[1],
                        width: imageSize,
                        onTap: () {
                          selectingPokemon(context, 1);
                        },
                      ),
                    ),
                    Container(
                      width: selectorWidth,
                      child: PokemonSelectorBuilderWidget(
                        selectedPokemon: selectedPokemon[2],
                        width: imageSize,
                        onTap: () {
                          selectingPokemon(context, 2);
                        },
                      ),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: selectorWidth,
                      child: PokemonSelectorBuilderWidget(
                        selectedPokemon: selectedPokemon[3],
                        width: imageSize,
                        onTap: () {
                          selectingPokemon(context, 3);
                        },
                      ),
                    ),
                    Container(
                      width: selectorWidth,
                      child: PokemonSelectorBuilderWidget(
                        selectedPokemon: selectedPokemon[4],
                        width: imageSize,
                        onTap: () {
                          selectingPokemon(context, 4);
                        },
                      ),
                    ),
                    Container(
                      width: selectorWidth,
                      child: PokemonSelectorBuilderWidget(
                        selectedPokemon: selectedPokemon[5],
                        width: imageSize,
                        onTap: () {
                          selectingPokemon(context, 5);
                        },
                      ),
                    )
                  ]),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: RaisedGradientButton(
                child: Text(
                  'Clear selected pokemon',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .merge(TextStyle(color: Colors.white)),
                ),
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.grey[800]!,
                    Colors.grey[700]!,
                    Colors.grey[600]!,
                    Colors.grey[700]!,
                    Colors.grey[800]!
                  ],
                ),
                onPressed: () {
                  setState(() {
                    selectedPokemon = List.filled(6, null);
                    activeTypeStringList = List.filled(3, []);
                    activeTypeValueList = List.filled(3, []);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void selectingPokemon(BuildContext context, int index) async {
    Pokemon? result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              SearchWidget(selectedPokemon[index], allPokemon, allType)),
    );

    setState(() {
      selectedPokemon[index] = result;
      panelController.open();
      List<List<int>> analyzinResult =
          Analyzing().teamAnalyzing(selectedPokemon, allType);
      teamProperties[0] = analyzinResult[0];
      teamProperties[1] = analyzinResult[1];
      activeTypeStringList[0] =
          Analyzing().getActiveTypeStringList(teamProperties[0], "<");
      activeTypeStringList[1] =
          Analyzing().getActiveTypeStringList(teamProperties[0], ">");
      activeTypeStringList[2] =
          Analyzing().getActiveTypeStringList(teamProperties[1], ">");
      activeTypeValueList[0] =
          Analyzing().getActiveTypeValueList(teamProperties[0], "<");
      activeTypeValueList[1] =
          Analyzing().getActiveTypeValueList(teamProperties[0], ">");
      activeTypeValueList[2] =
          Analyzing().getActiveTypeValueList(teamProperties[1], ">");
    });
  }
}
