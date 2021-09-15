import 'package:flutter/material.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonInfoScreen extends StatefulWidget {
  PokemonInfoScreen({Key? key}) : super(key: key);

  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final PokemonsRepo _repo;
  late Pokemon _pokemon;
  final int _index = 1;

  _PokemonInfoScreenState() : _repo = new PokemonsRepo();

  Future<Pokemon> getPokemon() async {
    var pokemon = await _repo.getPokemonByIndex(_index);
    return pokemon;
  }

  Widget buildHeader(Pokemon pokemon) {
    return Column(children: [
      Text(
        pokemon.name,
        style: Theme.of(context).textTheme.headline4,
      ),
      getPokemonTypes(pokemon)
    ]);
  }

  Widget getPokemonTypes(Pokemon pokemon) {
    List<Widget> items = [];
    for (var type in pokemon.types) {
      if (type == 'grass') {
        items.add(Text(
          type,
          style: TextStyle(backgroundColor: Colors.green[600]),
        ));
      } else
        items.add(Text(
          type,
          style: TextStyle(backgroundColor: Colors.purple[800]),
        ));
    }
    return Row(
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              FutureBuilder(
                  future: getPokemon(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return buildHeader(snapshot.data as Pokemon);
                    }
                    return CircularProgressIndicator();
                  }),
              Image.asset('assets/images/1.png'),
            ],
          ),
        ),
        SlidingUpPanel(
          panel: Center(
            child: Text("This is the sliding Widget"),
          ),
          collapsed: Container(
            decoration:
                BoxDecoration(color: Colors.blueGrey, borderRadius: radius),
            child: Center(
              child: Text(
                "This is the collapsed Widget",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
