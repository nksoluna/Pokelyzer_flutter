import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

List<Pokemon> searchWithType(
    List<Pokemon> allPokemon, List<Type> allType, List<bool> types) {
  List<String> selectedType = [];
  List<Pokemon> selectedPokemon = [];
  for (int i = 0; i < 18; i++) {
    if (types[i]) selectedType.add(allType[i].name);
  }
  allPokemon.forEach((element) => {
        if (element.types.any((ele) => ele == selectedType[0].toLowerCase()))
          {selectedPokemon.add(element)}
      });
  if (selectedType.length > 1) {
    for (int i = 1; i < selectedType.length; i++) {
      List<Pokemon> selectedPokemonAfter = [];
      selectedPokemon.forEach((element) => {
            if (element.types
                .any((ele) => ele.contains(selectedType[i].toLowerCase())))
              {selectedPokemonAfter.add(element)}
          });
      selectedPokemon = selectedPokemonAfter;
    }
  }
  return selectedPokemon;
}

List<Pokemon> searchWithName(List<Pokemon> allPokemon, String input) {
  List<Pokemon> selectedPokemons = [];
  input = input.toLowerCase();
  allPokemon.forEach((element) => {
        if (element.name.contains(input)) {selectedPokemons.add(element)}
      });
  return selectedPokemons;
}

List<Pokemon> searchWithIndex(int i, List<Pokemon> allPokemon) {
  List<Pokemon> selectedPokemon = [];

  selectedPokemon.add(allPokemon.firstWhere((element) => element.index == i));
  return selectedPokemon;
}

List<Pokemon> searchPokemon(
    String inputIndex,
    String inputName,
    List<bool> selectedTypeArray,
    List<Pokemon> allPokemon,
    List<Type> allType) {
  List<Pokemon> selectedPokemon = [];
  if (!selectedTypeArray.any((element) => element) &&
      inputIndex.isEmpty &&
      inputName.isEmpty) selectedPokemon = allPokemon;
  selectedPokemon = allPokemon;

  if (inputIndex.isNotEmpty && int.parse(inputIndex) <= allPokemon.length) {
    selectedPokemon = searchWithIndex(int.parse(inputIndex), selectedPokemon);
  }
  if (inputName.isNotEmpty) {
    selectedPokemon = searchWithName(selectedPokemon, inputName);
  }
  if (selectedTypeArray.any((element) => element)) {
    selectedPokemon =
        searchWithType(selectedPokemon, allType, selectedTypeArray);
  }
  return selectedPokemon;
}
