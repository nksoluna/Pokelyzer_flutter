import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_circle.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/CustomWidgets/searchWidget.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CompareScreen extends StatefulWidget {
  CompareScreen({Key? key}) : super(key: key);

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  List<Pokemon?> selectedPokemon = List.filled(2, null);
  PanelController _pc = PanelController();
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
      panelController: _pc,
      tabBar: ['Stat', 'Weakness'],
      panelRadius: 24,
      panelBody: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Wrap(
            runSpacing: 5,
            children: [
              Row(
                children: [
                  Text('HP: '),
                  SizedBox(width: 23),
                  Expanded(
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        buildPercentBar(
                          value: selectedPokemon[0]?.stats.hp,
                          color: Colors.blue,
                        ),
                        buildPercentBar(
                          value: selectedPokemon[1]?.stats.hp,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('ATK: '),
                  SizedBox(width: 15),
                  Expanded(
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        buildPercentBar(
                          value: selectedPokemon[0]?.stats.atk,
                          color: Colors.blue,
                        ),
                        buildPercentBar(
                          value: selectedPokemon[1]?.stats.atk,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('DEF: '),
                  SizedBox(width: 16),
                  Expanded(
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        buildPercentBar(
                          value: selectedPokemon[0]?.stats.def,
                          color: Colors.blue,
                        ),
                        buildPercentBar(
                          value: selectedPokemon[1]?.stats.def,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('SPATK: '),
                  Expanded(
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        buildPercentBar(
                          value: selectedPokemon[0]?.stats.spatk,
                          color: Colors.blue,
                        ),
                        buildPercentBar(
                          value: selectedPokemon[1]?.stats.spatk,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('SPDEF: '),
                  Expanded(
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        buildPercentBar(
                          value: selectedPokemon[0]?.stats.spdef,
                          color: Colors.blue,
                        ),
                        buildPercentBar(
                          value: selectedPokemon[1]?.stats.spdef,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('SPD: '),
                  SizedBox(width: 15),
                  Expanded(
                    child: Wrap(
                      runSpacing: 5,
                      children: [
                        buildPercentBar(
                          value: selectedPokemon[0]?.stats.spd,
                          color: Colors.blue,
                        ),
                        buildPercentBar(
                          value: selectedPokemon[1]?.stats.spd,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Center(child: Text('Weakness Screenadd')),
      ],
      children: [
        Text('Compare Pokemon',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .merge(TextStyle(fontWeight: FontWeight.bold))),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              selectedPokemon.length,
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
              _pc.open();
            },
          ),
        ),
      ],
    );
  }

  Widget buildPercentBar({
    Widget? leading,
    num? value,
    double max = 255,
    Color color = Colors.red,
  }) {
    if (value == null) value = 0.0;
    return LinearPercentIndicator(
      lineHeight: 20.0,
      leading: leading,
      percent: value / max,
      center: Text("${value}"),
      linearStrokeCap: LinearStrokeCap.butt,
      progressColor: color,
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
    });
  }
}
