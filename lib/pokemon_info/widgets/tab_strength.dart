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

  Widget buildStrength() => (Container(
          child: Stack(
        children: [
          Row(
            children: [
              Text('Resistances',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(
                height: 38,
              ),
              Column(children: [
                Row(
                  children: [],
                )
              ])
            ],
          )
        ],
      )));
  Widget buildWeakness() => (Container(
          child: Stack(
        children: [
          Row(
            children: [
              Text('Weaknesses',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(
                height: 38,
              ),
              Column(children: [
                Row(
                  children: [],
                )
              ])
            ],
          )
        ],
      )));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildWeakness(),
          buildStrength(),
        ],
      ),
      padding: EdgeInsets.fromLTRB(33, 27, 0, 0),
      alignment: Alignment.topLeft,
    );
  }
}
