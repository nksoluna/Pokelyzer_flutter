import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/favpokemon.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type_pokemon.dart';
import 'package:pokelyzer/Screens/PokemonInfo/pokemon_info.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final box = Hive.box<Favpokemon>('favpokemon');
  bool _hasmore = true;
  int _pokemonnumber = 1;
  bool _error = false;
  int _nextPokemonThreshold = 10;
  final int _defaultPkmnPerPage = 10;
  List<Favpokemon> _favpokemon = <Favpokemon>[];
  List<Pokemon> _pokemon = [];
  List<Pokemon> _allpokemon = [];
  List<TypePokemon> _allType = [];
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _hasmore = true;
    _pokemonnumber = 1;
    _nextPokemonThreshold = 10;
    _error = false;
    _favpokemon = [];
    _pokemon = [];

    fetchpokemon();
  }

  Future<void> fetchpokemon() async {
    final box = Hive.box<Favpokemon>('favpokemon');
    try {
      final allPokemonbox = Hive.box<Pokemon>('allpokemon');
      final allTypeBox = Hive.box<TypePokemon>('alltype');
      List<Pokemon> pokemonlist = [];
      pokemonlist.addAll(allPokemonbox.values);
      List<TypePokemon> typelist = [];
      typelist.addAll(allTypeBox.values);
      List<Favpokemon> favlist = box.values.toList();
      setState(
        () {
          _hasmore = favlist.length == _defaultPkmnPerPage;
          _pokemonnumber = _pokemonnumber + 1;
          _nextPokemonThreshold = 10;
          _allType = typelist;
          _favpokemon = favlist;
          _allpokemon = pokemonlist;
          pokemonlist.forEach((element) {
            for (int i = 0; i < _favpokemon.length; i++) {
              if (_favpokemon[i].name == element.name) {
                _pokemon.add(element);
              }
            }
          });
          if (_favpokemon.isNotEmpty) {
            _favpokemon = _favpokemon.toSet().toList();
            _favpokemon.sort((a, b) => a.index.compareTo(b.index));
          }
        },
      );
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: BaseWidget(children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
                  child: Stack(
                    children: [
                      getBody(),
                    ],
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(170, 0, 0, 0),
                child: Stack(
                  children: [
                    Row(children: [
                      Text(
                        'Favorites',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        width: 30,
                        height: 30,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red[700],
                          hoverColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              box.clear();
                              _favpokemon = [];
                            });
                          },
                          child: Icon(
                            Icons.close,
                            size: 20,
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget getBody() {
    if (_favpokemon.isEmpty) {
      return Container(
        child: Center(
          child: Text('NONE FAV'),
        ),
      );
    }
    return ListView.builder(
        itemCount: _favpokemon.length + (_hasmore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _favpokemon.length) {
            fetchpokemon();
          }
          if (index == _favpokemon.length + _nextPokemonThreshold) {
            if (_error) {
              return Center(
                child: InkWell(
                  onTap: () => setState(
                    () {
                      _error = false;
                      fetchpokemon();
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        "Error while loading more Data ,Please tap to try again"),
                  ),
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          try {
            for (int i = 0; i < _favpokemon.length; i++) {
              if (i != index) {
                if (_favpokemon[index].name == _favpokemon[i].name) {
                  _favpokemon[_favpokemon.length - 1].delete();
                }
              }
            }
          } catch (e) {
            return Container();
          }
          final Favpokemon _favpkmns = _favpokemon[index];

          final Pokemon _pkmns = _pokemon.elementAt(index);
          double screenwidth = MediaQuery.of(context).size.width;
          Color typeColor = Color(0xFFFFFFFF);
          var types = _favpkmns.types[0];
          final typeLength = _favpkmns.types.length;
          bool fav = _favpokemon.toString().contains(_pkmns.name);

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

          return Card(
              elevation: 4,
              shadowColor: Colors.grey,
              margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              color: typeColor.withOpacity(0.6),
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(
                        MaterialPageRoute(
                            builder: (context) => PokemonInfoScreen(
                                  _allpokemon,
                                  _pkmns,
                                  _allType,
                                  fav,
                                )),
                      )
                      .then((value) => setState(() {
                            fetchpokemon();
                          }));
                },
                child: Row(
                  children: <Widget>[
                    Container(
                        height: 81,
                        width: 135,
                        child: Image.asset(
                          'assets/images/pokemons/${_favpkmns.index}.png',
                          height: 81,
                          width: 135,
                        )),
                    Column(
                      children: [
                        Stack(children: [
                          Padding(
                            // change style paddding
                            padding: const EdgeInsets.fromLTRB(0, 35, 20, 10),
                            child: Column(children: [
                              Align(
                                  child: Text(
                                '${_favpkmns.name.toUpperCase()}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: screenwidth * 0.04,
                                  shadows: <Shadow>[
                                    Shadow(
                                        offset: Offset(0, 2),
                                        blurRadius: 0,
                                        color: Colors.grey)
                                  ],
                                ),
                              )),
                            ]),
                          )
                        ]),
                        Stack(children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
                              child: Row(
                                children: List.generate(typeLength, (index) {
                                  return Container(
                                    height: 35,
                                    width: 70,
                                    child: Card(
                                      color: Palette().getSelectedTypeColor(
                                          _favpkmns.types[index],
                                          getAllTypeInString()),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(_favpkmns.types[index],
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                  );
                                }),
                              ))
                        ]),
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
