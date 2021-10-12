import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/Helpers/searchFunction.dart';
import 'package:pokelyzer/Helpers/string_extension.dart';
import 'package:pokelyzer/Screens/favorites/boxes.dart';
import 'package:pokelyzer/models/favpokemon.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type_pokemon.dart';
import 'package:pokelyzer/Screens/pokemon_info/widgets/tab_stat.dart';
import 'package:pokelyzer/Screens/pokemon_info/widgets/tab_strength.dart';
import 'package:pokelyzer/Screens/pokemon_info/widgets/tab_move.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfoScreen extends StatefulWidget {
  final List<Pokemon> allPokemon;
  final Pokemon pokemon;
  final List<TypePokemon> allType;
  bool isfav;
  PokemonInfoScreen(this.allPokemon, this.pokemon, this.allType, this.isfav);
  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final box = Hive.box<Favpokemon>('favpokemon');
  final panelController = PanelController();
  List<TypePokemon> _allType = [];
  bool issave = false;

  @override
  void initState() {
    super.initState();
    _allType = widget.allType;
    issave = widget.isfav;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildPokemonTypes(Pokemon pokemon) {
    final typeLength = pokemon.types.length;
    return Row(
        children: List.generate(typeLength, (index) {
      return Container(
        height: 35,
        width: 70,
        child: Card(
          color: Palette()
              .getSelectedTypeColor(pokemon.types[index], getAllTypeInString()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: Text(pokemon.types[index],
                style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }));
  }

  Future addfav(int index, String name, List<String> types, bool _isfav) async {
    final favpokemon = Favpokemon(0, '', [])
      ..index = index
      ..name = name
      ..types = types;

    final box = Boxes.getFavpokemon();
    if (_isfav == false) {
      box.add(favpokemon);
    } else {
      deletefav(favpokemon);
    }
  }

  void deletefav(Favpokemon favpokemon) async {
    List<Favpokemon> _favpokemon = <Favpokemon>[];
    var favbox = box.values.toList();
    _favpokemon.addAll(favbox);
    for (int i = 0; i < _favpokemon.length; i++) {
      if (favpokemon.name == _favpokemon[i].name) {
        _favpokemon[i].delete();
      }
    }
    print(_favpokemon);
  }

  Widget buildfavbutton(
      BuildContext context, Favpokemon favpokemon, int position, bool issaved) {
    return InkWell(
      child: StarButton(
        isStarred: issaved,
        valueChanged: (_isStarred) {
          addfav(
              favpokemon.index, favpokemon.name, favpokemon.types, !_isStarred);
        },
        iconSize: 40,
      ),
    );
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

  Widget buildSlidingPanel({
    required PanelController panelController,
    required ScrollController scrollController,
    required Pokemon pokemon,
  }) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    );
    return SlidingUpPanel(
        renderPanelSheet: false,
        controller: panelController,
        borderRadius: radius,
        panelSnapping: true,
        panel: DefaultTabController(
            length: 3,
            child: GestureDetector(
              onTap: () => panelController.open(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Palette().getColorFromPokemonType(pokemon),
                  centerTitle: true,
                  title: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 100,
                    height: 8,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: radius),
                  bottom: TabBar(tabs: [
                    Tab(text: "Stat"),
                    Tab(text: "Strength"),
                    Tab(text: "Moves")
                  ]),
                ),
                body: Container(
                  color: Colors.white,
                  child: TabBarView(
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
                    ],
                  ),
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final panelController = PanelController();
    var screenSize = MediaQuery.of(context).size;
    var listIndex = getEvolutionsChainIndex(widget.allPokemon, widget.pokemon);
    Favpokemon favpokemon = new Favpokemon(0, '', []);
    favpokemon.index = widget.pokemon.index;
    favpokemon.name = widget.pokemon.name;
    favpokemon.types = widget.pokemon.types;
    int position = 0;
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor:
            Palette().getColorFromPokemonType(widget.pokemon).withOpacity(0.4),
        appBar: AppBar(
          backgroundColor: Palette().getColorFromPokemonType(widget.pokemon),
          title: Text(
            "Index NO.${widget.pokemon.index.toString()}",
            style: TextStyle(fontStyle: FontStyle.normal),
          ),
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 5),
                child: buildfavbutton(context, favpokemon, position, issave))
          ],
        ),
        body: Stack(children: <Widget>[
          Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                controller: scrollController,
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
                    GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: List.generate(listIndex.length, (index) {
                          return Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Image.asset(
                                'assets/images/pokemons/${listIndex[index]}.png'),
                          );
                        })),
                    SizedBox(height: 40),
                  ],
                ),
              )),
          buildSlidingPanel(
              scrollController: scrollController,
              panelController: panelController,
              pokemon: widget.pokemon),
        ]),
      ),
    );
  }
}
