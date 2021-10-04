import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/Helpers/searchFunction.dart';
import 'package:pokelyzer/Helpers/string_extension.dart';
import 'package:pokelyzer/Screens/favorites/boxes.dart';
import 'package:pokelyzer/models/favpokemon.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:pokelyzer/Screens/pokemon_info/widgets/tab_stat.dart';
import 'package:pokelyzer/Screens/pokemon_info/widgets/tab_strength.dart';
import 'package:pokelyzer/Screens/pokemon_info/widgets/tab_move.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfoScreen extends StatefulWidget {
  final List<Pokemon> allPokemon;
  final Pokemon pokemon;
  final List<Type> allType;
  bool isfav;
  PokemonInfoScreen(this.allPokemon, this.pokemon, this.allType, this.isfav);
  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final panelController = PanelController();
  final double tabBarHeight = 80;
  List<Type> _allType = [];
  bool issave = false;

  @override
  void initState() {
    super.initState();
    _allType = widget.allType;
    issave = widget.isfav;
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  Color getcolor(Pokemon pokemon) {
    Color typeColor = Color(0xFFFFFFFF);
    var types = pokemon.types[0];
    switch (types) {
      case 'normal':
        typeColor = Color(0xFFA8A878);
        break;
      case 'fire':
        typeColor = Color(0xFFF08030);
        break;
      case 'water':
        typeColor = Color(0xFF6890F0);
        break;
      case 'grass':
        typeColor = Color(0xFF78C850);
        break;
      case 'electric':
        typeColor = Color(0xFFF8D030);
        break;
      case 'ice':
        typeColor = Color(0xFF98D8D8);
        break;
      case 'fighting':
        typeColor = Color(0xFFC03028);
        break;
      case 'poison':
        typeColor = Color(0xFFA040A0);
        break;
      case 'ground':
        typeColor = Color(0xFFE0C068);
        break;
      case 'flying':
        typeColor = Color(0xFFA890F0);
        break;
      case 'psychic':
        typeColor = Color(0xFFF85888);
        break;
      case 'bug':
        typeColor = Color(0xFFA8B820);
        break;
      case 'rock':
        typeColor = Color(0xFFB8A038);
        break;
      case 'ghost':
        typeColor = Color(0xFF705898);
        break;
      case 'dark':
        typeColor = Color(0xFF705848);
        break;
      case 'dragon':
        typeColor = Color(0xFF7038F8);
        break;
      case 'steel':
        typeColor = Color(0xB8B8D0);
        break;
      case 'fairy':
        typeColor = Color(0xFFEE99AC);
        break;
    }
    return typeColor;
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
              borderRadius: BorderRadius.circular(28),
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
    var box = await Hive.openBox<Favpokemon>('favpokemon');
    List<Favpokemon> _favpokemon = <Favpokemon>[];
    var favbox = box.values.toList();
    _favpokemon.addAll(favbox);
    for (int i = 0; i < _favpokemon.length; i++) {
      if (favpokemon.name == _favpokemon[i].name) {
        _favpokemon[i].delete();
      }
    }
  }

  Widget buildfavbutton(
      BuildContext context, Favpokemon favpokemon, int position, bool issaved) {
    var box = Hive.openBox<Favpokemon>('favpokemon');
    return InkWell(
      child: StarButton(
        isStarred: issaved,
        valueChanged: (_isStarred) {
          if (_isStarred == true) {
            addfav(favpokemon.index, favpokemon.name, favpokemon.types,
                !_isStarred);
            print('${favpokemon.name} fav');
          } else {
            addfav(favpokemon.index, favpokemon.name, favpokemon.types,
                !_isStarred);
            print('${favpokemon.name} unfav');
          }
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
        // maxHeight: MediaQuery.of(context).size.height * 0.56,
        // minHeight: MediaQuery.of(context).size.height * 0.08,
        panel: DefaultTabController(
            length: 3,
            child: GestureDetector(
              onTap: () => panelController.open(),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: getcolor(pokemon),
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
        backgroundColor: getcolor(widget.pokemon).withOpacity(0.4),
        appBar: AppBar(
          backgroundColor: getcolor(widget.pokemon),
          title: Text(widget.pokemon.name.capitalize()),
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
