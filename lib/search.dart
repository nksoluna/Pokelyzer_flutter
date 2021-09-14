List<dynamic> searchWithType(List<dynamic> allpokemon, List<bool> types) {
  var selectedPokemons = allpokemon;
  List<int> typeIndex = [];
  for (int i = 0; i < 18; i++) {
    if (types[i]) typeIndex.add(i);
  }

  return selectedPokemons;
}

List<dynamic> searchWithIndex(int i, List<dynamic> allPokemon) {
  var selectedPokemon = [];

  selectedPokemon
      .add(allPokemon.firstWhere((element) => element["index"] == i));
  return selectedPokemon;
}
