import 'package:flutter/material.dart';
import 'package:pokelyzer/models/pokemon.dart';

class TabSrengthWidget extends StatelessWidget {
  final Pokemon pokemon;
  const TabSrengthWidget({
    Key? key,
    required this.scrollController,
    required this.pokemon,
  }) : super(key: key);
  final ScrollController scrollController;

  Widget buildStrength() => Text("Strength");
  Widget buildWeakness() => Text("Weakness");
  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [buildStrength(), buildWeakness()],
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
