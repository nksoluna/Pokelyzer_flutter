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

  Widget buildEvolution() {
    if (pokemon.evolutions.isEmpty) {
      return Text("None Evolution");
    } else
      return Container(
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              child: Image.asset('assets/images/pokemons/${pokemon.index}.png'),
            );
          },
        ),
      );
  }

  // Widget buildChainEvolutionImages(Pokemon pokemon) {
  //return image of evolution

  //   return items;
  // }

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [buildEvolution()],
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
