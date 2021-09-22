import 'package:flutter/material.dart';
import 'package:pokelyzer/models/pokemon.dart';

class TabEvolutionWidget extends StatelessWidget {
  final Pokemon pokemon;
  const TabEvolutionWidget({
    Key? key,
    required this.scrollController,
    required this.pokemon,
  }) : super(key: key);
  final ScrollController scrollController;

  Widget buildEvolution(Pokemon pokemon) {
    final int evolutionChainNumber = pokemon.evolutions.length;

    return Container(
      child: Center(
        child: Text("d"),
      ),
      padding: EdgeInsets.all(20),
      alignment: Alignment.center,
    );
    // if (pokemon.evolutions.isEmpty) {
    //   return Text("None Evolution");
    // } else
    //   return Container(
    //     child: GridView.builder(
    //       physics: NeverScrollableScrollPhysics(),
    //       shrinkWrap: true,
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: pokemon.evolutions.length,
    //         crossAxisSpacing: 5.0,
    //         mainAxisSpacing: 5.0,
    //       ),
    //       itemCount: pokemon.evolutions.length,
    //       itemBuilder: (context, index) {
    //         print(pokemon.evolutions.indexOf(pokemon.name));
    //         return Container(
    //           child: Image.asset('assets/images/pokemons/${pokemon.index}.png'),
    //         );
    //       },
    //     ),
    //   );
  }

  // Widget buildChainEvolutionImages(Pokemon pokemon) {
  //return image of evolution

  //   return items;
  // }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSize = screenSize.width / 4;
    return buildEvolution(pokemon);
  }
}
