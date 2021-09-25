import 'package:flutter/services.dart';
import 'dart:convert';

class Type {
  final String name;
  final List<String> weaknessesOffensive;
  final List<String> immunesOffensive;
  final List<String> strengthsOffensive;
  final List<String> weaknessesDefensive;
  final List<String> immunesDefensive;
  final List<String> strengthsDefensive;
  Type(
      this.name,
      this.immunesOffensive,
      this.immunesDefensive,
      this.weaknessesOffensive,
      this.weaknessesDefensive,
      this.strengthsOffensive,
      this.strengthsDefensive);
  factory Type.fromJson(dynamic json) {
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
    return Type(json["name"], immuneA, immuneD, weaknessA, weaknessD, strengthA,
        strengthD);
  }
}

Future<List<Type>> readAllTypeFromJson() async {
  final String typeResponse = await rootBundle.loadString('assets/types.json');
  final typeData = await json.decode(typeResponse);
  List<Type> allType = [];
  for (int i = 0; i < 18; i++) {
    allType.add(Type.fromJson(typeData[i]));
  }
  return allType;
}

Future<Map<String, Type>> getAllTypeInMap() async {
  final String typeResponse = await rootBundle.loadString('assets/types.json');
  final typeData = await json.decode(typeResponse);
  Map<String, Type> allType = {};
  for (int i = 0; i < 18; i++) {
    Type typeItem = Type.fromJson(typeData[i]);
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
