import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/analyzing.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/type.dart';

class PropertiesShow extends StatefulWidget {
  final List<int> properties;
  final String propertiesToShow;
  PropertiesShow(this.properties, this.propertiesToShow);
  @override
  PropertiesShowState createState() => PropertiesShowState();
}

class PropertiesShowState extends State<PropertiesShow> {
  List<String> allTypeString = getAllTypeInString();
  double headerFontSize = 17;
  double dataFontSize = 17;
  Widget createTypeTag(int index) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 100,
          child: Card(
            color: Palette()
                .getSelectedTypeColor(allTypeString[index], allTypeString),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(allTypeString[index],
                  style:
                      TextStyle(color: Colors.white, fontSize: dataFontSize)),
            ),
          ),
        ),
        Text(" x "),
        Text(widget.properties[index].abs().toString())
      ],
    );
  }

  Widget listTypeShow(String operator) {
    if (operator == ">")
      return Column(
        children: Analyzing().totalActiveStrengthType(widget.properties) <= 9
            ? [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 100),
                    Column(
                      children: List.generate(18, (index) {
                        if (widget.properties[index] > 0) {
                          return Column(
                            children: [
                              createTypeTag(index),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ]
            : [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: List.generate(9, (index) {
                        if (widget.properties[index] > 0) {
                          return Column(
                            children: [
                              createTypeTag(index),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                    ),
                    Column(
                      children: List.generate(9, (index) {
                        if (widget.properties[index + 9] > 0) {
                          return Column(
                            children: [
                              createTypeTag(index + 9),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                    )
                  ],
                )
              ],
      );
    else
      return Column(
        children: Analyzing().totalActiveWeaknessType(widget.properties) <= 9
            ? [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 100),
                    Column(
                      children: List.generate(18, (index) {
                        if (widget.properties[index] < 0) {
                          return Column(
                            children: [
                              createTypeTag(index),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ]
            : [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: List.generate(9, (index) {
                        if (widget.properties[index] < 0) {
                          return Column(
                            children: [
                              createTypeTag(index),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                    ),
                    Column(
                      children: List.generate(9, (index) {
                        if (widget.properties[index + 9] < 0) {
                          return Column(
                            children: [
                              createTypeTag(index + 9),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                    )
                  ],
                )
              ],
      );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        widget.propertiesToShow == "Strength"
            ? Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your team  has pokemon(s) that take",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " 0.5x ",
                        style: TextStyle(
                            fontSize: headerFontSize, color: Colors.green),
                      ),
                      Text(
                        "damage from...",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  listTypeShow(">")
                ],
              )
            : SizedBox(),
        widget.propertiesToShow == "Weakness"
            ? Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your team has pokemon(s) that take",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " 2x ",
                        style: TextStyle(
                            fontSize: headerFontSize, color: Colors.red),
                      ),
                      Text(
                        "damage from...",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  listTypeShow("<"),
                ],
              )
            : SizedBox(),
        widget.propertiesToShow == "Immune"
            ? Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your team has pokemon(s) that ",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't ",
                        style: TextStyle(
                            fontSize: headerFontSize, color: Colors.grey[700]),
                      ),
                      Text(
                        "take damage ",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                      Text(
                        "[0x] ",
                        style: TextStyle(
                            fontSize: headerFontSize, color: Colors.grey[700]),
                      ),
                      Text(
                        "from...",
                        style: TextStyle(fontSize: headerFontSize),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  listTypeShow(">"),
                ],
              )
            : SizedBox(),
      ]),
    );
  }
}
