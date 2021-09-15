import 'package:flutter/material.dart';
import 'package:pokelyzer/CustomWidgets/base.dart';
import 'package:pokelyzer/models/pokemon.dart';

class PokemonInfoScreen extends StatefulWidget {
  PokemonInfoScreen({Key? key}) : super(key: key);

  @override
  _PokemonInfoScreenState createState() => _PokemonInfoScreenState();
}

class _PokemonInfoScreenState extends State<PokemonInfoScreen> {
  final PokemonsRepo _repo;
  late Pokemon _pokemon;
  late int _index;

  _PokemonInfoScreenState() : _repo = new PokemonsRepo();

  void initState() {
    super.initState();
    _index = 1;
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    var pokemon = await _repo.getPokemonByIndex(_index);
    setState(() {
      _pokemon = pokemon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(children: [Center(child: Text(_pokemon.name))]);
  }
}
