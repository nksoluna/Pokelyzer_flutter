import 'package:hive/hive.dart';
import 'package:pokelyzer/models/favpokemon.dart';

class Boxes {
  static Box<Favpokemon> getFavpokemon() => Hive.box<Favpokemon>('Favpokemon');
}
