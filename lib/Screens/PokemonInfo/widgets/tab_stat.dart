import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pokelyzer/models/pokemon.dart';

class TabStatWidget extends StatelessWidget {
  final Pokemon pokemon;
  const TabStatWidget({
    Key? key,
    required this.scrollController,
    required this.pokemon,
  }) : super(key: key);
  final ScrollController scrollController;

  Widget buildStatsBar() => Column(children: [
        Padding(
            padding: const EdgeInsets.all(30),
            child: Wrap(runSpacing: 15, children: [
              Container(
                child: Row(
                  children: [
                    Container(width: 70, child: Text("HP")),
                    Container(width: 50, child: Text("${pokemon.stats.hp}")),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: pokemon.stats.hp / 255,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(width: 70, child: Text("ATK")),
                    Container(width: 50, child: Text("${pokemon.stats.atk}")),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: pokemon.stats.atk / 255,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(width: 70, child: Text("DEF")),
                    Container(width: 50, child: Text("${pokemon.stats.def}")),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: pokemon.stats.def / 255,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(width: 70, child: Text("Sp.ATK")),
                    Container(width: 50, child: Text("${pokemon.stats.spatk}")),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: pokemon.stats.spatk / 255,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(width: 70, child: Text("Sp.DEF")),
                    Container(width: 50, child: Text("${pokemon.stats.spdef}")),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: pokemon.stats.spdef / 255,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(width: 70, child: Text("SPEED")),
                    Container(width: 50, child: Text("${pokemon.stats.spd}")),
                    Expanded(
                      child: LinearPercentIndicator(
                        lineHeight: 10,
                        percent: pokemon.stats.spd / 255,
                        progressColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ]))
      ]);

  @override
  Widget build(BuildContext context) => Container(
        child: buildStatsBar(),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
