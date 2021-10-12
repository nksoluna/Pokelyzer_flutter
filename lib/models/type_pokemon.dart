import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:hive/hive.dart';
part 'type_pokemon.g.dart';

@HiveType(typeId: 7)
class TypePokemon {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<String> weaknessesOffensive;
  @HiveField(2)
  final List<String> immunesOffensive;
  @HiveField(3)
  final List<String> strengthsOffensive;
  @HiveField(4)
  final List<String> weaknessesDefensive;
  @HiveField(5)
  final List<String> immunesDefensive;
  @HiveField(6)
  final List<String> strengthsDefensive;
  TypePokemon(
      this.name,
      this.immunesOffensive,
      this.immunesDefensive,
      this.weaknessesOffensive,
      this.weaknessesDefensive,
      this.strengthsOffensive,
      this.strengthsDefensive);
  factory TypePokemon.fromJson(dynamic json) {
    List<String> weaknessA = [],
        immuneA = [],
        strengthA = [],
        weaknessD = [],
        immuneD = [],
        strengthD = [];
    for (int i = 0; i < json["weaknesses-offensive"].length; i++) {
      weaknessA.add(json["weaknesses-offensive"][i]);
    }
    for (int i = 0; i < json["immunes-offensive"].length; i++) {
      immuneA.add(json["immunes-offensive"][i]);
    }
    for (int i = 0; i < json["strengths-offensive"].length; i++) {
      strengthA.add(json["strengths-offensive"][i]);
    }
    for (int i = 0; i < json["weaknesses-defensive"].length; i++) {
      weaknessD.add(json["weaknesses-defensive"][i]);
    }
    for (int i = 0; i < json["immunes-defensive"].length; i++) {
      immuneD.add(json["immunes-defensive"][i]);
    }
    for (int i = 0; i < json["strengths-defensive"].length; i++) {
      strengthD.add(json["strengths-defensive"][i]);
    }
    return TypePokemon(json["name"], immuneA, immuneD, weaknessA, weaknessD,
        strengthA, strengthD);
  }
}

Future<List<TypePokemon>> readAllTypeFromJson() async {
  final String typeResponse = await rootBundle.loadString('assets/types.json');
  final typeData = await json.decode(typeResponse);
  List<TypePokemon> allType = [];
  for (int i = 0; i < 18; i++) {
    allType.add(TypePokemon.fromJson(typeData[i]));
  }
  return allType;
}

Future<Map<String, TypePokemon>> getAllTypeInMap() async {
  final String typeResponse = await rootBundle.loadString('assets/types.json');
  final typeData = await json.decode(typeResponse);
  Map<String, TypePokemon> allType = {};
  for (int i = 0; i < 18; i++) {
    TypePokemon typeItem = TypePokemon.fromJson(typeData[i]);
    allType[typeItem.name] = typeItem;
  }
  return allType;
}

List<String> getAllTypeInString() {
  return [
    "normal",
    "fire",
    "water",
    "electric",
    "grass",
    "ice",
    "fighting",
    "poison",
    "ground",
    "flying",
    "psychic",
    "bug",
    "rock",
    "ghost",
    "dragon",
    "dark",
    "steel",
    "fairy"
  ];
}
