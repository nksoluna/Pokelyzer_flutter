import 'package:flutter/services.dart';
import 'dart:convert';

class Pokemon {
  final int index;
  final String name;
  final List<String> types;
  final Stat stats;
  final List<Ability> abilities;
  final List<String> evolutions;
  final List<Move> moves;
  Pokemon(this.index, this.name, this.types, this.stats, this.abilities,
      this.evolutions, this.moves);

  factory Pokemon.fromJson(dynamic json) {
    List<Ability> ability = [];
    List<String> type = [];
    List<String> evolution = [];
    List<Move> move = [];
    for (int i = 0; i < json["type"].length; i++) {
      type.add(json["type"][i]);
    }
    for (int i = 0; i < json["evolutions"].length; i++) {
      evolution.add(json["evolutions"][i]);
    }
    for (int i = 0; i < json["abilities"].length; i++) {
      ability.add(Ability.fromJson(json["abilities"][i]));
    }
    for (int i = 0; i < json["moves"].length; i++) {
      move.add(Move.fromJson(json["moves"][i]));
    }
    return Pokemon(json["index"], json["name"], type,
        Stat.fromJson(json["stats"]), ability, evolution, move);
  }
}

class Stat {
  final int hp;
  final int atk;
  final int def;
  final int spatk;
  final int spdef;
  final int spd;
  Stat(this.hp, this.atk, this.def, this.spatk, this.spdef, this.spd);
  factory Stat.fromJson(dynamic json) {
    return Stat(json["HP"], json["ATK"], json["DEF"], json["SPATK"],
        json["SPDEF"], json["SPD"]);
  }
}

class Ability {
  final String name;
  final bool ishidden;
  Ability(this.name, this.ishidden);
  factory Ability.fromJson(dynamic json) {
    return Ability(json["ability"], json["is_hidden"]);
  }
}

class Move {
  final String name;
  final int power;
  final int accuracy;
  final int pp;
  final String damageType;
  final String damageClass;
  Move(this.name, this.power, this.accuracy, this.pp, this.damageType,
      this.damageClass);
  factory Move.fromJson(dynamic json) {
    return Move(json["name"], json["power"], json["accuracy"], json["pp"],
        json["type"], json["class"]);
  }
}

Future<List<Pokemon>> readAllPokemonFromJson() async {
  final String pkmnResponse =
      await rootBundle.loadString('assets/pokemons.json');
  final pkmnData = await json.decode(pkmnResponse);
  List<Pokemon> allPokemon = [];
  for (int i = 0; i < 807; i++) {
    allPokemon.add(Pokemon.fromJson(pkmnData[i]));
  }
  return allPokemon;
}
