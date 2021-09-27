import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/CustomWidgets/pokemon_selector_circle.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/CustomWidgets/search_widget.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/Helpers/string_extension.dart';
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
  List<Color> textColors = [Colors.blue, Colors.red];
  PanelController _pc = PanelController();
  List<Pokemon> allPokemon = [];
  Map<String, Type> allTypeInMap = {};
  List<Type> allType = [];
  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    allPokemon = await PokemonsRepo().readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
    allTypeInMap = await getAllTypeInMap();
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
                      children: List.generate(
                        selectedPokemon.length,
                        (index) => buildPercentBar(
                          value: selectedPokemon[index]?.stats.hp,
                          color: textColors[index],
                        ),
                      ),
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
                      children: List.generate(
                        selectedPokemon.length,
                        (index) => buildPercentBar(
                          value: selectedPokemon[index]?.stats.atk,
                          color: textColors[index],
                        ),
                      ),
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
                      children: List.generate(
                        selectedPokemon.length,
                        (index) => buildPercentBar(
                          value: selectedPokemon[index]?.stats.def,
                          color: textColors[index],
                        ),
                      ),
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
                      children: List.generate(
                        selectedPokemon.length,
                        (index) => buildPercentBar(
                          value: selectedPokemon[index]?.stats.spatk,
                          color: textColors[index],
                        ),
                      ),
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
                      children: List.generate(
                        selectedPokemon.length,
                        (index) => buildPercentBar(
                          value: selectedPokemon[index]?.stats.spdef,
                          color: textColors[index],
                        ),
                      ),
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
                      children: List.generate(
                        selectedPokemon.length,
                        (index) => buildPercentBar(
                          value: selectedPokemon[index]?.stats.spd,
                          color: textColors[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(30),
          alignment: Alignment.center,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            runSpacing: 5,
            children: buildWeaknessWidget(),
          ),
        ),
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
                textColor: textColors[index],
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
              _pc.open();
            },
          ),
        ),
      ],
    );
  }

  List<Widget> buildWeaknessWidget() {
    Widget buildSinglePokemonType(String type) {
      Widget buildCard({required String text, Color? color}) {
        var cardColor = color;
        if (color == null) {
          cardColor =
              Palette().getSelectedTypeColor(text, getAllTypeInString());
        }
        return Container(
          height: 45,
          width: 100,
          child: Card(
            color: cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(text, style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      }

      return buildCard(text: type);
    }

    if (selectedPokemon[0] != null && selectedPokemon[1] != null) {
      Pokemon pokemon1 = selectedPokemon[0]!;
      Pokemon pokemon2 = selectedPokemon[1]!;
      List<Widget> weaknessWidget = [];
      TextStyle style = TextStyle(fontSize: 22);
      for (var type1 in pokemon1.types) {
        for (var type2 in pokemon2.types) {
          bool firstWeakToSec = allTypeInMap[type1.capitalize()]!
              .weaknessesOffensive
              .contains(type2.capitalize());
          bool secWeakToFirst = allTypeInMap[type2.capitalize()]!
              .weaknessesOffensive
              .contains(type1.capitalize());
          // print('>>>$type1, $type2');
          // print(firstWeakToSec);
          // print(allTypeInMap[type1.capitalize()]!.weaknessesOffensive);
          // print('>>>$type2, $type1');
          // print(secWeakToFirst);
          // print(allTypeInMap[type2.capitalize()]!.weaknessesOffensive);
          // print('-------------------');
          Widget result = Column(children: [
            Text('Neutral to', style: style),
            Text('<---------->', style: style)
          ]);
          if (firstWeakToSec && !secWeakToFirst) {
            result = Column(children: [
              Text('Weak to', style: style),
              Text('<-----------',
                  style: style.merge(TextStyle(color: Colors.red)))
            ]);
          } else if (!firstWeakToSec && secWeakToFirst) {
            result = Column(children: [
              Text('Strong to', style: style),
              Text('----------->',
                  style: style.merge(TextStyle(color: Colors.blue)))
            ]);
          }
          weaknessWidget.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSinglePokemonType(type1),
              result,
              buildSinglePokemonType(type2),
            ],
          ));
        }
      }
      return weaknessWidget;
    }
    return [Text('Please Select Pokemons')];
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
