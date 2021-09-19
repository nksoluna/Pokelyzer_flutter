import 'package:flutter/material.dart';
import 'package:pokelyzer/models/pokemon.dart';

class TabMoveWidget extends StatelessWidget {
  final Pokemon pokemon;
  const TabMoveWidget({
    Key? key,
    required this.scrollController,
    required this.pokemon,
  }) : super(key: key);
  final ScrollController scrollController;

  Widget buildMove() => Text("Move");

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [buildMove()],
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
