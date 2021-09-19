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

  Widget buildEvolution() => Text("Evolution");
  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [buildEvolution()],
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
