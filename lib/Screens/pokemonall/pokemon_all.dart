import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/Screens/pokemonall/drawer/drawer.dart';
import 'package:pokelyzer/models/pokemon.dart';

class AllpokemonScreen extends StatefulWidget {
  AllpokemonScreen({Key? key}) : super(key: key);

  @override
  _AllpokemonScreenState createState() => _AllpokemonScreenState();
}

class _AllpokemonScreenState extends State<AllpokemonScreen> {
  bool _hasmore = true;
  int _pokemonnumber = 1;
  bool _error = false;
  bool _loading = true;
  int _nextPokemonThreshold = 10;
  final int _defaultPkmnPerPage = 10;
  List<Pokemon> _pokemon = [];
  @override
  void initState() {
    super.initState();
    _hasmore = true;
    _pokemonnumber = 1;
    _nextPokemonThreshold = 10;
    _error = false;
    _loading = true;
    _pokemon = _pokemon;

    fetchpokemon();
  }

  Future<void> fetchpokemon() async {
    try {
      List<Pokemon> pokemonlist = await PokemonsRepo().readAllPokemonFromJson();

      setState(
        () {
          _hasmore = pokemonlist.length == _defaultPkmnPerPage;
          _loading = false;
          _pokemonnumber = _pokemonnumber + 1;
          _nextPokemonThreshold = 10;
          _pokemon.addAll(pokemonlist);
        },
      );
    } catch (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue,
          drawer: PokemonDrawer(),
          body: Stack(children: <Widget>[
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              "./assets/material-image/background-firstpage.jpg",
                            ),
                            fit: BoxFit.cover,
                          )),
                        ),
                        Expanded(
                            child: Stack(
                          children: [
                            Text('Tesdt'),
                            SizedBox(
                              height: 100,
                            ),
                            Text('test2'),
                            getBody(),
                          ],
                        )),
                        Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 4.0,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                size: 30,
                              ),
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? null
                                  : Colors.black,
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              tooltip: MaterialLocalizations.of(context)
                                  .openAppDrawerTooltip,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  Widget getBody() {
    if (_loading) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: CircularProgressIndicator(), // loading with circular loader
      ));
    } else if (_error) {
      // if error = true
      return Center(
        child: InkWell(
          onTap: () => setState(
            () {
              _loading =
                  true; //change loading to true and trying load same page
              _error = false; //change error to false
              fetchpokemon(); // tap to set new State
            },
          ),
          child: Padding(
            // if cannot loading
            padding: const EdgeInsets.all(16),
            child: Text(
                "Error While Loading Data. Please Try Again"), // return this text to change the upper state
          ),
        ),
      );
    } else {
      // if error = false
      return ListView.builder(
          itemCount: _pokemon.length +
              (_hasmore
                  ? 1
                  : 0), // itemCount = amount of people and if _hasmore = true this count will stop in last element
          itemBuilder: (context, index) {
            if (index == _pokemon.length) {
              // if people.length has more     than nextpagethreshold
              fetchpokemon(); //fetching people
            }
            if (index == _pokemon.length + _nextPokemonThreshold) {
              if (_error) {
                // same as error
                return Center(
                  child: InkWell(
                    onTap: () => setState(
                      () {
                        _loading = true;
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
                    child: CircularProgressIndicator(), // Primary Swatch
                  ),
                );
              }
            }
            final Pokemon _pkmns = _pokemon[index];
            double screenwidth = MediaQuery.of(context).size.width;
            Color typeColor = Color(0xFFFFFFFF);
            var types = _pkmns.types[0];
            print('INDEX :  ${_pkmns.index}');
            print('Name :  ${_pkmns.name}');
            print('Type : $types');
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
              color: typeColor,
              child: Row(
                children: <Widget>[
                  Container(
                      height: 81,
                      width: 135,
                      child: Image.asset(
                        'assets/images/${_pkmns.index}.png',
                        height: 81,
                        width: 135,
                      )),
                  Padding(
                    // change style paddding
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${_pkmns.name.toUpperCase()}',
                            textAlign: TextAlign.center,
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
                  ),
                ],
              ),
            );
          });
    }
  }
}