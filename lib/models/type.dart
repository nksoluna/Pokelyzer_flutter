import 'package:flutter/services.dart';
import 'dart:convert';

class Type {
  final String name;
  final List<String> weaknesses;
  final List<String> immunes;
  final List<String> strengths;
  Type(this.name, this.immunes, this.weaknesses, this.strengths);
  factory Type.fromJson(dynamic json) {
    List<String> weakness = [], immune = [], strength = [];
    for (int i = 0; i < json["weaknesses"].length; i++) {
      weakness.add(json["weaknesses"][i]);
    }
    for (int i = 0; i < json["immunes"].length; i++) {
      immune.add(json["immunes"][i]);
    }
    for (int i = 0; i < json["strengths"].length; i++) {
      strength.add(json["strengths"][i]);
    }
    return Type(json["name"], weakness, immune, strength);
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
