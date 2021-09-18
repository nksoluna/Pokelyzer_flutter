import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

class Analyzing {
  void AnalyzingWeakness(
    Pokemon? pokemon1,
    Pokemon? pokemon2,
    Pokemon? pokemon3,
    Pokemon? pokemon4,
    Pokemon? pokemon5,
    Pokemon? pokemon6,
    List<Pokemon> allPokemon,
    List<Type> allType,
  ) {
    List<Pokemon> teamPokemon = [];
    List<String> allTypeString = getAllTypeInString();
    List<int> totalWeakness = List.filled(18, 0);
    List<int> totalInputType = List.filled(18, 0);
    if (pokemon1 != null) teamPokemon.add(pokemon1);
    if (pokemon2 != null) teamPokemon.add(pokemon2);
    if (pokemon3 != null) teamPokemon.add(pokemon3);
    if (pokemon4 != null) teamPokemon.add(pokemon4);
    if (pokemon5 != null) teamPokemon.add(pokemon5);
    if (pokemon6 != null) teamPokemon.add(pokemon6);
    teamPokemon.forEach((element) {
      for (int i = 0; i < 18; i++) {
        if (element.types[0].contains(allTypeString[i])) {
          totalInputType[i] += 1;
        }
      }
      if (element.types.length == 2) {
        for (int i = 0; i < 18; i++) {
          if (element.types[1].contains(allTypeString[i])) {
            totalInputType[i] += 1;
          }
        }
      }
    });
  }
}
