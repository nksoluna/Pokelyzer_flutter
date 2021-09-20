import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/Helpers/string_extension.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_evolution.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_stat.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_strength.dart';
import 'package:pokelyzer/pokemon_info/widgets/tab_move.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:pokelyzer/models/type.dart';

class PokemonInfoScreen extends StatefulWidget {
  final Pokemon pokemon;

  PokemonInfoScreen(this.pokemon);
  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final panelController = PanelController();
  final double tabBarHeight = 80;
  List<Type> _allType = [];

  @override
  void initState() {
    super.initState();
    fetchAllTypes();
  }

  Future<void> fetchAllTypes() async {
    try {
      List<Type> allType = await readAllTypeFromJson();
      _allType.addAll(allType);
    } catch (e) {
      print(e);
    }
  }

  Widget buildPokemonTypes(Pokemon pokemon) {
    if (pokemon != null) {
      final typeLength = pokemon.types.length;
      return Row(
          children: List.generate(typeLength, (index) {
        return Container(
          height: 35,
          width: 70,
          child: Card(
            color: Palette().getSelectedTypeColor(
                pokemon.types[index], getAllTypeInString()),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(pokemon.types[index],
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        );
      }));
    } else {
      return Text('???');
    }
  }

  Widget buildHeader(Pokemon pokemon) {
    return SafeArea(
        child: Column(children: [
      Row(
        children: [
          Text(
            pokemon.name.capitalize(),
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
      buildPokemonTypes(pokemon)
    ]));
  }

  List<int> getListIndex(Pokemon pokemon) {
    List<int> indexes = [];
    final evolutionIndex = pokemon.evolutions.indexOf(pokemon.name);
    var index = 0;
    if (evolutionIndex == 2) {
      index = -2;
    } else if (evolutionIndex == 1) {
      index = -1;
    }

    for (var i = 0; i < pokemon.evolutions.length; i++) {
      indexes.add(pokemon.index + index);
      index++;
    }

    return indexes;
  }

  Widget buildSlidingPanel({
    required PanelController panelController,
    required ScrollController scrollController,
    required Pokemon pokemon,
  }) =>
      Column(
        children: [
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xffff2626),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(28.0),
                topLeft: Radius.circular(28.0),
              ),
            ),
          ),
          Expanded(
              child: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: buildTabBar(
                onClicked: panelController.open,
              ) as PreferredSizeWidget,
              body: TabBarView(
                children: [
                  TabStatWidget(
                    scrollController: scrollController,
                    pokemon: pokemon,
                  ),
                  TabSrengthWidget(
                    scrollController: scrollController,
                    pokemon: pokemon,
                    allType: _allType,
                  ),
                  TabMoveWidget(
                    scrollController: scrollController,
                    pokemon: pokemon,
                  ),
                  TabEvolutionWidget(
                    scrollController: scrollController,
                    pokemon: pokemon,
                  ),
                ],
              ),
            ),
          ))
        ],
      );

  Widget buildTabBar({
    required VoidCallback onClicked,
  }) =>
      PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight - 31),
        child: GestureDetector(
          onTap: onClicked,
          child: AppBar(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     top: Radius.circular(20),
            //   ),
            // ),
            automaticallyImplyLeading: false,
            // title: buildDragIcon(), //Icon(Icons.drag_handle),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(child: Text('Stat')),
                Tab(child: Text('Strength')),
                Tab(child: Text('Move')),
                Tab(child: Text('Evolution')),
              ],
            ),
          ),
        ),
      );

  Widget buildDragIcon() => Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 8,
      );

  @override
  Widget build(BuildContext context) {
    final panelController = PanelController();
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.width / 4;
    getListIndex(widget.pokemon);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.pokemon.name),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  buildHeader(widget.pokemon),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: screenSize.height / 3,
                      width: double.infinity,
                      // alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/pokemons/${widget.pokemon.index}.png',
                        height: screenSize.height / 1.6,
                        width: screenSize.width / 1.6,
                      )),
                  SizedBox(height: 30),
                  Text(
                    "Evolution Chain",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: List.generate(
                          getListIndex(widget.pokemon).length,
                          (index) => Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(getListIndex(widget.pokemon)[index]
                                    .toString()),
                              )))
                ],
              ),
            ),
            SlidingUpPanel(
              borderRadius: BorderRadius.circular(28),
              controller: panelController,
              panelSnapping: true,
              maxHeight: MediaQuery.of(context).size.height * 0.46,
              minHeight: MediaQuery.of(context).size.height * 0.08,
              panelBuilder: (scrollController) => buildSlidingPanel(
                  scrollController: scrollController,
                  panelController: panelController,
                  pokemon: widget.pokemon),
            ),
          ],
        ));
  }
}
