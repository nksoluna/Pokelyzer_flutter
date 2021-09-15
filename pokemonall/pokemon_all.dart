import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/Screens/Home/drawer/drawer.dart';
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
                          constraints: BoxConstraints.expand(),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              "./assets/material-image/background-firstpage.jpg",
                            ),
                            fit: BoxFit.cover,
                          )),
                        ),
                        SizedBox(
                          height: 172,
                        ),
                        getBody(),
                        Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 4.0),
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
            print('INDEX :  ${_pkmns.index}');
            print('Name :  ${_pkmns.name}');
            return Card(
              color: Colors.amber,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/${_pkmns.index}.png',
                    height: 81,
                    width: 135,
                  ),
                  Padding(
                    // change style paddding
                    padding: const EdgeInsets.fromLTRB(82, 40, 0, 40),
                    child: Column(children: [
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${_pkmns.name}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )),
                    ]),
                  )
                ],
              ),
            );
          });
    }
  }
}
