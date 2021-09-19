import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

class Analyzing {
  List<Pokemon> pokemonToList(
    Pokemon? pokemon1,
    Pokemon? pokemon2,
    Pokemon? pokemon3,
    Pokemon? pokemon4,
    Pokemon? pokemon5,
    Pokemon? pokemon6,
  ) {
    List<Pokemon> teamPokemon = [];
    if (pokemon1 != null) teamPokemon.add(pokemon1);
    if (pokemon2 != null) teamPokemon.add(pokemon2);
    if (pokemon3 != null) teamPokemon.add(pokemon3);
    if (pokemon4 != null) teamPokemon.add(pokemon4);
    if (pokemon5 != null) teamPokemon.add(pokemon5);
    if (pokemon6 != null) teamPokemon.add(pokemon6);
    return teamPokemon;
  }

  List<int> AnalyzingWeakness(
    Pokemon? pokemon1,
    Pokemon? pokemon2,
    Pokemon? pokemon3,
    Pokemon? pokemon4,
    Pokemon? pokemon5,
    Pokemon? pokemon6,
    List<Pokemon> allPokemon,
    List<Type> allType,
  ) {
    List<Pokemon> teamPokemon = pokemonToList(
        pokemon1, pokemon2, pokemon3, pokemon4, pokemon5, pokemon6);
    List<String> allTypeString = getAllTypeInString();
    List<int> totalWeakness = List.filled(18, 0);
    List<int> totalInputType = List.filled(18, 0);
    teamPokemon.forEach((element) {
      totalInputType[allTypeString.indexOf(element.types[0].toLowerCase())] +=
          1;
      if (element.types.length == 2)
        totalInputType[allTypeString.indexOf(element.types[1].toLowerCase())] +=
            1;
    });
    for (int i = 0; i < 18; i++) {
      if (totalInputType[i] > 0) {
        List<String> weakness = allType[i].weaknessesDefensive;
        print(weakness);
        weakness.forEach((element) {
          totalWeakness[allTypeString.indexOf(element.toLowerCase())] +=
              totalInputType[i];
        });
      }
    }
    return totalWeakness;
  }
}
