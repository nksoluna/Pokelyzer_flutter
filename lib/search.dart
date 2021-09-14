import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

List<dynamic> searchWithType(
    List<dynamic> allpokemon, List<dynamic> allType, List<bool> types) {
  List selectedPokemons = allpokemon;
  List selectedType = [];
  for (int i = 0; i < 18; i++) {
    if (types[i]) selectedType.add(allType[i]);
  }
  selectedPokemons.retainWhere((element) =>
      element.types.any((ele) => ele == selectedType[0].name.toLowerCase()));

  return selectedPokemons;
}

List<dynamic> searchWithIndex(int i, List<dynamic> allPokemon) {
  var selectedPokemon = [];

  selectedPokemon
      .add(allPokemon.firstWhere((element) => element["index"] == i));
  return selectedPokemon;
}
