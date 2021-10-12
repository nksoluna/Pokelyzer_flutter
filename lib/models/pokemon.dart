import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
part 'pokemon.g.dart';

@HiveType(typeId: 2)
class Pokemon {
  @HiveField(1)
  final int index;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final List<String> types;
  @HiveField(4)
  final Stat stats;
  @HiveField(5)
  final List<Ability> abilities;
  @HiveField(6)
  final List<String> evolutions;
  @HiveField(7)
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

  @override
  toString() => '$name';
}

@HiveType(typeId: 3)
class Stat {
  @HiveField(1)
  final int hp;
  @HiveField(2)
  final int atk;
  @HiveField(3)
  final int def;
  @HiveField(4)
  final int spatk;
  @HiveField(5)
  final int spdef;
  @HiveField(6)
  final int spd;
  Stat(this.hp, this.atk, this.def, this.spatk, this.spdef, this.spd);
  factory Stat.fromJson(dynamic json) {
    return Stat(json["HP"], json["ATK"], json["DEF"], json["SPATK"],
        json["SPDEF"], json["SPD"]);
  }
}

@HiveType(typeId: 4)
class Ability {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool ishidden;
  @HiveField(1)
  Ability(this.name, this.ishidden);
  factory Ability.fromJson(dynamic json) {
    return Ability(json["ability"], json["is_hidden"]);
  }
}

@HiveType(typeId: 5)
class Move {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int power;
  @HiveField(3)
  final int accuracy;
  @HiveField(4)
  final int pp;
  @HiveField(5)
  final String damageType;
  @HiveField(6)
  final String damageClass;
  Move(this.name, this.power, this.accuracy, this.pp, this.damageType,
      this.damageClass);
  factory Move.fromJson(dynamic json) {
    return Move(json["name"], json["power"], json["accuracy"], json["pp"],
        json["type"], json["class"]);
  }
}

class PokemonsRepo {
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

  Future<Pokemon> getPokemonByIndex(int index) async {
    final String pkmnResponse =
        await rootBundle.loadString('assets/pokemons.json');
    final pkmnData = await json.decode(pkmnResponse);
    Pokemon pokemon = Pokemon.fromJson(pkmnData[index]);
    return pokemon;
  }
}
