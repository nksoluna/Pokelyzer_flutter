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

Color gettypeColor(Move move) {
  Color typeColor = Color(0xFFFFFFFF) ;
    var types = move.damageType ;
     switch (types) {
              case 'normal':
                typeColor = Color(0xFFA8A878);
                break;
              case 'fire':
                typeColor = Color(0xFFF08030);
                break;
              case 'water':
                typeColor = Color(0xFF6890F0);
                break;
              case 'grass':
                typeColor = Color(0xFF78C850);
                break;
              case 'electric':
                typeColor = Color(0xFFF8D030);
                break;
              case 'ice':
                typeColor = Color(0xFF98D8D8);
                break;
              case 'fighting':
                typeColor = Color(0xFFC03028);
                break;
              case 'poison':
                typeColor = Color(0xFFA040A0);
                break;
              case 'ground':
                typeColor = Color(0xFFE0C068);
                break;
              case 'flying':
                typeColor = Color(0xFFA890F0);
                break;
              case 'psychic':
                typeColor = Color(0xFFF85888);
                break;
              case 'bug':
                typeColor = Color(0xFFA8B820);
                break;
              case 'rock':
                typeColor = Color(0xFFB8A038);
                break;
              case 'ghost':
                typeColor = Color(0xFF705898);
                break;
              case 'dark':
                typeColor = Color(0xFF705848);
                break;
              case 'dragon':
                typeColor = Color(0xFF7038F8);
                break;
              case 'steel':
                typeColor = Color(0xB8B8D0);
                break;
              case 'fairy':
                typeColor = Color(0xFFEE99AC);
                break;
            }
  return typeColor ;
}

  Widget buildMove() => Expanded(
      child: ListView.builder(
          itemCount: pokemon.moves.length,
          itemBuilder: (context, index) {
            return Card(
               // color: Colors.grey[350],
               color: gettypeColor(pokemon.moves[index]).withOpacity(0.7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        child: Text(pokemon.moves[index].name,
                            style: TextStyle(fontSize: 14 ,color: Colors.white)),
                      ),
                      Column(
                        children: [
                          Text("Power", style: TextStyle(fontSize: 12,color: Colors.white),),
                          Text(
                            pokemon.moves[index].power.toString(),
                            style: TextStyle(fontSize: 11,color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("ACC", style: TextStyle(fontSize: 12,color: Colors.white)),
                          Text(
                            pokemon.moves[index].accuracy.toString() + '%',
                            style: TextStyle(fontSize: 11 ,color:Colors.white ),
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
