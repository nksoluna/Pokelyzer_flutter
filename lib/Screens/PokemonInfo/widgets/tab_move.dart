import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type_pokemon.dart';

class TabMoveWidget extends StatelessWidget {
  final Pokemon pokemon;
  const TabMoveWidget({
    Key? key,

    required this.pokemon,
  }) : super(key: key);


  Color getClassColor(Move move) {
    Color classColor = Color(0xFFFFFFFF);
    var classes = move.damageClass;
    switch (classes) {
      case 'status':
        classColor = Color(0x8C888C);
        break;
      case 'physical':
        classColor = Color(0xC92112);
        break;
      case 'special':
        classColor = Color(0x4F5870);
        break;
    }
    return classColor;
  }

  Widget buildMove() => Expanded(
      child: ListView.builder(
          itemCount: pokemon.moves.length,
          itemBuilder: (context, index) {
            return Card(
                // color: Colors.grey[350],
                color: Palette()
                    .getColorFromMove(pokemon.moves[index])
                    .withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        child: Text(pokemon.moves[index].name,
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                      ),
                      Column(
                        children: [
                          Text(
                            "Power",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          Text(
                            pokemon.moves[index].power.toString(),
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ACC",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          Text(
                            pokemon.moves[index].accuracy.toString() + '%',
                            style: TextStyle(fontSize: 11, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            height: 25,
                            width: 60,
                            child: Card(
                              color: getClassColor(pokemon.moves[index])
                                  .withOpacity(0.7),
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
