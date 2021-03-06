import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type_pokemon.dart';

class Analyzing {
  teamAnalyzing(List<Pokemon?> selectedPokemon, List<TypePokemon> allType) {
    List<int> result = List.filled(18, 0);
    List<int> immuneProperty = List.filled(18, 0);
    selectedPokemon.forEach((element) {
      if (element != null) {
        List<List<int>> elementResult = singleAnalyzing(element, allType);
        for (int i = 0; i < 18; i++) {
          result[i] += elementResult[0][i];
          immuneProperty[i] += elementResult[1][i];
        }
      }
    });
    List<List<int>> finalResult = [];
    finalResult.add(result);
    finalResult.add(immuneProperty);
    return finalResult;
  }

  List<List<int>> singleAnalyzing(Pokemon? pokemon, List<TypePokemon> allType) {
    List<String> allTypeString = getAllTypeInString();
    List<int> result = List.filled(18, 0);
    List<int> pokemonTypeIndex = [];
    List<int> immuneProperty = List.filled(18, 0);
    if (pokemon == null) return List.filled(2, List.filled(18, 0));
    pokemon.types.forEach((element) {
      pokemonTypeIndex.add(allTypeString.indexOf(element.toLowerCase()));
    });
    pokemonTypeIndex.forEach((element) {
      List<String> weakness = allType[element].weaknessesDefensive;
      List<String> strength = allType[element].strengthsDefensive;
      List<String> immune = allType[element].immunesDefensive;
      int? immuneIndex;
      weakness.forEach((ele) {
        int weaknessIndex = allTypeString.indexOf(ele.toLowerCase());
        result[weaknessIndex] -= 1;
      });
      strength.forEach((ele) {
        int strengthIndex = allTypeString.indexOf(ele.toLowerCase());
        result[strengthIndex] += 1;
      });
      if (immune.length > 0) {
        immuneIndex = allTypeString.indexOf(immune[0].toLowerCase());
        immuneProperty[immuneIndex] += 1;
      }
    });
    if (immuneProperty.any((element) => element == 1)) {
      for (int i = 0; i < 18; i++) {
        if (immuneProperty[i] > 0) {
          result[i] = 0;
        }
      }
    }
    List<List<int>> propertiesAndImmune = [];
    propertiesAndImmune.add(result);
    propertiesAndImmune.add(immuneProperty);
    return propertiesAndImmune;
  }

  int totalActiveStrengthType(List<int> input) {
    int activeType = 0;
    input.forEach((element) {
      if (element > 0) activeType += 1;
    });
    return activeType;
  }

  int totalActiveWeaknessType(List<int> input) {
    int activeType = 0;
    input.forEach((element) {
      if (element < 0) activeType += 1;
    });
    return activeType;
  }

  List<String> getActiveTypeStringList(List<int> input, String operator) {
    List<String> allTypeString = getAllTypeInString();
    List<String> result = [];
    if (operator == ">")
      for (int i = 0; i < 18; i++) {
        if (input[i] > 0) result.add(allTypeString[i]);
      }
    else if (operator == "<")
      for (int i = 0; i < 18; i++) {
        if (input[i] < 0) result.add(allTypeString[i]);
      }
    return result;
  }

  List<int> getActiveTypeValueList(List<int> input, String operator) {
    List<int> result = [];
    if (operator == ">") {
      for (int i = 0; i < 18; i++) {
        if (input[i] > 0) result.add(input[i]);
      }
    }
    if (operator == "<") {
      for (int i = 0; i < 18; i++) {
        if (input[i] < 0) result.add(input[i]);
      }
    }
    return result;
  }
}
