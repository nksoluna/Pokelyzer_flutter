import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/analyzing.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';

class TabSrengthWidget extends StatelessWidget {
  final Pokemon pokemon;
  final List<Type> allType;
  const TabSrengthWidget({
    Key? key,
    required this.scrollController,
    required this.pokemon,
    required this.allType,
  }) : super(key: key);
  final ScrollController scrollController;

  Widget buildStrength(List<int> typeProperty, List<String> strengthList,
          List<String> allTypeString) =>
      (Container(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Resistances : ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(height: 10),
              Column(children: [
                strengthList.length <= 5
                    ? Row(
                        children: List.generate(strengthList.length, (index) {
                          return Container(
                            height: 30,
                            width: 65,
                            child: Card(
                              color: Palette().getSelectedTypeColor(
                                  allTypeString[allTypeString
                                      .indexOf(strengthList[index])],
                                  allTypeString),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(strengthList[index],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                            ),
                          );
                        }),
                      )
                    : Column(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Container(
                                height: 30,
                                width: 65,
                                child: Card(
                                  color: Palette().getSelectedTypeColor(
                                      allTypeString[allTypeString
                                          .indexOf(strengthList[index])],
                                      allTypeString),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(strengthList[index],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  ),
                                ),
                              );
                            }),
                          ),
                          strengthList.length <= 10
                              ? Row(
                                  children: List.generate(
                                      strengthList.length - 5, (index) {
                                    return Container(
                                      height: 30,
                                      width: 65,
                                      child: Card(
                                        color: Palette().getSelectedTypeColor(
                                            allTypeString[allTypeString.indexOf(
                                                strengthList[index + 5])],
                                            allTypeString),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(strengthList[index + 5],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              : Row(
                                  children: List.generate(5, (index) {
                                    return Container(
                                      height: 30,
                                      width: 65,
                                      child: Card(
                                        color: Palette().getSelectedTypeColor(
                                            allTypeString[allTypeString.indexOf(
                                                strengthList[index + 5])],
                                            allTypeString),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(strengthList[index + 5],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15)),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                          strengthList.length > 10
                              ? Row(
                                  children: List.generate(
                                      strengthList.length - 10, (index) {
                                    return Container(
                                      height: 30,
                                      width: 65,
                                      child: Card(
                                        color: Palette().getSelectedTypeColor(
                                            allTypeString[allTypeString.indexOf(
                                                strengthList[index + 10])],
                                            allTypeString),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(strengthList[index + 10],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10)),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              : SizedBox()
                        ],
                      )
              ]),
              SizedBox(height: 10),
            ],
          )
        ],
      )));
  Widget buildWeakness(List<int> typeProperty, List<String> weaknessList,
          List<String> allTypeString) =>
      (Container(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Weaknesses : ',
                  style: TextStyle(
                    fontSize: 18,
                  )),
              SizedBox(height: 10),
              Column(children: [
                weaknessList.length <= 5
                    ? Row(
                        children: List.generate(weaknessList.length, (index) {
                          return Container(
                            height: 30,
                            width: 65,
                            child: Card(
                              color: Palette().getSelectedTypeColor(
                                  allTypeString[allTypeString
                                      .indexOf(weaknessList[index])],
                                  allTypeString),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(weaknessList[index],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ),
                            ),
                          );
                        }),
                      )
                    : Column(
                        children: [
                          Row(
                            children: List.generate(5, (index) {
                              return Container(
                                height: 30,
                                width: 65,
                                child: Card(
                                  color: Palette().getSelectedTypeColor(
                                      allTypeString[allTypeString
                                          .indexOf(weaknessList[index])],
                                      allTypeString),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(weaknessList[index],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  ),
                                ),
                              );
                            }),
                          ),
                          Row(
                            children:
                                List.generate(weaknessList.length - 5, (index) {
                              return Container(
                                height: 30,
                                width: 65,
                                child: Card(
                                  color: Palette().getSelectedTypeColor(
                                      allTypeString[allTypeString
                                          .indexOf(weaknessList[index + 5])],
                                      allTypeString),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(weaknessList[index + 5],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      )
              ]),
              SizedBox(height: 10),
            ],
          )
        ],
      )));

  Widget buildImmune(List<int> typeProperty, List<String> immuneList,
          List<String> allTypeString) =>
      (Container(
          child: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Immunes : ',
              style: TextStyle(
                fontSize: 18,
              )),
          SizedBox(height: 10),
          Column(children: [
            Row(
              children: List.generate(immuneList.length, (index) {
                return Container(
                  height: 30,
                  width: 65,
                  child: Card(
                    color: Palette().getSelectedTypeColor(
                        allTypeString[allTypeString.indexOf(immuneList[index])],
                        allTypeString),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(immuneList[index],
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                );
              }),
            )
          ])
        ])
      ])));

  @override
  Widget build(BuildContext context) {
    List<List<int>> typeProperty =
        Analyzing().singleAnalyzing(pokemon, allType);
    List<String> allTypeString = getAllTypeInString();
    List<String> weaknessList =
        Analyzing().getActiveTypeStringList(typeProperty[0], "<");
    List<String> strengthList =
        Analyzing().getActiveTypeStringList(typeProperty[0], ">");
    List<String> immuneList =
        Analyzing().getActiveTypeStringList(typeProperty[1], ">");
    return Container(
      child: Column(
        children: [
          buildWeakness(typeProperty[0], weaknessList, allTypeString),
          buildStrength(typeProperty[0], strengthList, allTypeString),
          buildImmune(typeProperty[1], immuneList, allTypeString),
        ],
      ),
      padding: EdgeInsets.fromLTRB(33, 27, 0, 0),
      alignment: Alignment.topLeft,
    );
  }
}
