import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokelyzer/pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PokemonOverallInfo extends StatefulWidget {
  // final Pokemon pokemon;

  // const PokemonOverallInfo(this.pokemon);

  @override
  _PokemonOverallInfoState createState() => _PokemonOverallInfoState();
}

class _PokemonOverallInfoState extends State<PokemonOverallInfo> {
  // final PokemonRepo _repo;
  late Pokemon _pokemon;
  late int _index;

  // _PokemonOverallInfoState() : _repo = new PokemonRepo();

  @override
  void initState() {
    super.initState();
    _index = 1;
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    // var pokemon = await _repo.fetchPokemon(index: _index);
    setState(() {
      // _pokemon = pokemon;
    });
  }

  AppBar _buildAppBar() {
    fetchPokemon();
    return AppBar(
      title: Text("_pokemon.name"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildAppBar(),
        //build pokemon name
      ],
    );
  }
}
