import 'dart:convert';
import 'package:flutter/cupertino.dart';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));
String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  @required
  final int index;
  @required
  final String name;
  final Stats stats;
  final List<String> type;
  final List<Ability> abilities;
  final List<Move> moves;
  final List<String> evolutions;

  Pokemon(
    this.index,
    this.name,
    this.stats,
    this.type,
    this.abilities,
    this.moves,
    this.evolutions,
  );

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        json["index"],
        json["name"],
        Stats.fromJson(json["stats"]),
        List<String>.from(json["type"].map((x) => x)),
        List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
        List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        List<String>.from(json["evolutions: "].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "name": name,
        "stats": stats.toJson(),
        "type": List<dynamic>.from(type.map((x) => x)),
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "evolutions: ": List<dynamic>.from(evolutions.map((x) => x)),
      };
}

class Ability {
  Ability(
    this.ability,
    this.isHidden,
  );

  final String ability;
  final bool isHidden;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        json["ability"],
        json["is_hidden"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability,
        "is_hidden": isHidden,
      };
}

class Move {
  Move(
    this.name,
    this.power,
    this.accuracy,
    this.pp,
    this.type,
    // this.moveClass,
  );

  final String name;
  final int power;
  final int accuracy;
  final int pp;
  final String type;
  // final Class moveClass;

  factory Move.fromJson(Map<String, dynamic> json) => Move(
        json["name"],
        json["power"] == null ? null : json["power"],
        json["accuracy"] == null ? null : json["accuracy"],
        json["pp"],
        json["type"],
        // classValues.map![json["class"]],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "power": power == null ? null : power,
        "accuracy": accuracy == null ? null : accuracy,
        "pp": pp,
        "type": type,
        // "class": classValues.reverse[moveClass],
      };
}

enum Class { SPECIAL, STATUS, PHYSICAL }

final classValues = EnumValues({
  "physical": Class.PHYSICAL,
  "special": Class.SPECIAL,
  "status": Class.STATUS
});

class Stats {
  Stats(
    this.hp,
    this.atk,
    this.def,
    this.spatk,
    this.spdef,
    this.spd,
  );

  final int hp;
  final int atk;
  final int def;
  final int spatk;
  final int spdef;
  final int spd;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        json["HP"],
        json["ATK"],
        json["DEF"],
        json["SPATK"],
        json["SPDEF"],
        json["SPD"],
      );

  Map<String, dynamic> toJson() => {
        "HP": hp,
        "ATK": atk,
        "DEF": def,
        "SPATK": spatk,
        "SPDEF": spdef,
        "SPD": spd,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
