import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

class TabMoveWidget extends StatelessWidget {
  final Pokemon pokemon;
  const TabMoveWidget({
    Key? key,
    required this.scrollController,
    required this.pokemon,
  }) : super(key: key);
  final ScrollController scrollController;

  Widget buildMove() => Expanded(
      child: ListView.builder(
          itemCount: pokemon.moves.length,
          itemBuilder: (context, index) {
            return Card(
                color: Colors.grey[350],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        child: Text(pokemon.moves[index].name,
                            style: TextStyle(fontSize: 14)),
                      ),
                      Column(
                        children: [
                          Text("Power", style: TextStyle(fontSize: 12)),
                          Text(
                            pokemon.moves[index].power.toString(),
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ACC", style: TextStyle(fontSize: 12)),
                          Text(
                            pokemon.moves[index].accuracy.toString() + '%',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 25,
                            width: 60,
                            child: Card(
                              color: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(pokemon.moves[index].damageClass,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 60,
                            child: Card(
                              color: Palette().getSelectedTypeColor(
                                  pokemon.moves[index].damageType,
                                  getAllTypeInString()),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(pokemon.moves[index].damageType,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ));
          }));

  @override
  Widget build(BuildContext context) => Container(
        child: Column(
          children: [buildMove()],
        ),
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
      );
}
