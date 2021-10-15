import 'package:hive/hive.dart';
import 'package:pokelyzer/models/favpokemon.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type_pokemon.dart';

List<Pokemon> searchWithType(
    List<Pokemon> allPokemon, List<TypePokemon> allType, List<bool> types) {
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
    List<TypePokemon> allType) {
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

Pokemon searchWithSpacificName(List<Pokemon> allPokemon, String input) {
  Pokemon selectedPokemons;
  input = input.toLowerCase();
  selectedPokemons = allPokemon.firstWhere(
      (element) => element.name.toLowerCase() == input.toLowerCase());
  return selectedPokemons;
}

List<int> getEvolutionsChainIndex(List<Pokemon> allPokemon, Pokemon pokemon) {
  var evolutionChainPokemon = [];
  List<int> listIndex = [];
  List<int> result = [];
  pokemon.evolutions.forEach((pokemonName) {
    evolutionChainPokemon.add(searchWithSpacificName(allPokemon, pokemonName));
  });
  evolutionChainPokemon.forEach((element) {
    listIndex.add(element.index);
  });
  listIndex.sort();
  result = listIndex.toSet().toList();
  return result;
}

List<Pokemon> getFavouritePokemon() {
  final favbox = Hive.box<Favpokemon>('favpokemon');
  final allPokemonBox = Hive.box<Pokemon>('allpokemon');
  List<Pokemon> allPokemon = [];
  allPokemon.addAll(allPokemonBox.values);
  List<Pokemon> favPokemons = [];
  if (favbox.isNotEmpty)
    for (int i = 0; i < favbox.length; i++) {
      favPokemons.addAll(searchWithIndex(favbox.getAt(i)!.index, allPokemon));
    }
  return favPokemons;
}
