import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_teambuilder.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/CustomWidgets/searchWidget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/Helpers/analyzing.dart';
import 'package:pokelyzer/Screens/TeamBuilder/propertiesShow.dart';
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
  // weakness & strength[weakness is - , strength is + in list]  another is immune
  List<List<int>> teamProperties = List.filled(2, List.filled(18, 0));
  double selectorWidth = 120;
  bool isTeamChanged = false;
  final scrollController = ScrollController();
  final panelController = PanelController();
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
    var imageSize = screenSize.width / 4.5;
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(28.0),
      topRight: Radius.circular(28.0),
    );
    return Stack(
      children: <Widget>[
        BaseWidget(
          panelController: panelController,
          tabBar: ["Weakness", "Strength", "Immune"],
          panelRadius: 24,
          panelBody: [
            PropertiesShow(teamProperties[0], "Weakness"),
            PropertiesShow(teamProperties[0], "Strength"),
            PropertiesShow(teamProperties[1], "Immune")
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
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(right: imageSize / 2 - 20),
              child: RaisedGradientButton(
                child: Text(
                  'Analyze!',
                  style: TextStyle(color: Colors.white),
                ),
                width: 150,
                height: 30,
                gradient: LinearGradient(
                  colors: <Color>[Colors.red[700]!, Colors.red[400]!],
                ),
                onPressed: () {
                  panelController.open();
                  setState(() {
                    List<List<int>> result = Analyzing()
                        .teamAnalyzing(selectedPokemon, allPokemon, allType);
                    teamProperties[0] = result[0];
                    teamProperties[1] = result[1];
                    isTeamChanged = false;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            isTeamChanged
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.find_replace, color: Colors.red),
                      Text(
                        "Current analyzed data is from previous team!",
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  )
                : SizedBox()
          ],
        ), /*
        SlidingUpPanel(
            panelSnapping: true,
            borderRadius: radius,
            controller: panelController,
            minHeight: 80,
            panelBuilder: (scrollController) {
              return Column(
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.red[700],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(28.0),
                        topLeft: Radius.circular(28.0),
                      ),
                    ),
                  ),
                  Expanded(
                      child: DefaultTabController(
                          length: 3,
                          child: Scaffold(
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(50),
                              child: AppBar(
                                backgroundColor: Colors.red[700],
                                bottom: TabBar(
                                  tabs: [
                                    Tab(child: Text("Weakness")),
                                    Tab(child: Text("Strength")),
                                    Tab(child: Text("Immune"))
                                  ],
                                ),
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                PropertiesShow(teamProperties[0], "Weakness"),
                                PropertiesShow(teamProperties[0], "Strength"),
                                PropertiesShow(teamProperties[1], "Immune")
                              ],
                            ),
                          )))
                ],
              );
            })*/
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
      isTeamChanged = true;
      selectedPokemon[index] = result;
    });
  }
}
