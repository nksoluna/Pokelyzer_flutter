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

  Widget buildStatsBar() => Column(
        children: [
          Row(
            children: [
              Container(
                child: Text("HP"),
              ),
              Spacer(),
              new LinearPercentIndicator(
                width: 100.0,
                lineHeight: 8.0,
                percent: pokemon.stats.atk / 255,
                progressColor: Colors.blue,
              ),
              SizedBox(width: 120),
            ],
          ),
          Row(
            children: [
              Container(
                child: Text("ATK"),
              ),
              Spacer(),
              new LinearPercentIndicator(
                width: 100.0,
                lineHeight: 8.0,
                percent: pokemon.stats.atk / 255,
                progressColor: Colors.blue,
              ),
              SizedBox(width: 120),
            ],
          ),
          Row(
            children: [
              Text("DEF"),
              Spacer(),
              new LinearPercentIndicator(
                width: 100.0,
                lineHeight: 8.0,
                percent: pokemon.stats.def / 255,
                progressColor: Colors.blue,
              ),
              SizedBox(width: 120),
            ],
          ),
          Row(
            children: [
              Text("Sp.ATK"),
              Spacer(),
              new LinearPercentIndicator(
                width: 100.0,
                lineHeight: 8.0,
                percent: pokemon.stats.spatk / 255,
                progressColor: Colors.blue,
              ),
              SizedBox(width: 120),
            ],
          ),
          Row(
            children: [
              Text("Sp.DEF"),
              Spacer(),
              new LinearPercentIndicator(
                width: 100.0,
                lineHeight: 8.0,
                percent: pokemon.stats.spdef / 255,
                progressColor: Colors.blue,
              ),
              SizedBox(width: 120),
            ],
          ),
          Row(
            children: [
              Text("Speed"),
              Spacer(),
              new LinearPercentIndicator(
                width: 100.0,
                lineHeight: 8.0,
                percent: pokemon.stats.spd / 255,
                progressColor: Colors.blue,
              ),
              SizedBox(width: 120),
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) => Container(
        child: buildStatsBar(),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
