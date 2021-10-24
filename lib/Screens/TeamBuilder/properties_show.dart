import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:pokelyzer/models/type_pokemon.dart';

class PropertiesShow extends StatefulWidget {
  final List<int> activeTypeValue;
  final List<String> activeTypeString;
  final String propertiesToShow;
  PropertiesShow(
      this.activeTypeString, this.activeTypeValue, this.propertiesToShow);
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
            color: Palette().getSelectedTypeColor(
                widget.activeTypeString[index], allTypeString),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(widget.activeTypeString[index],
                  style:
                      TextStyle(color: Colors.white, fontSize: dataFontSize)),
            ),
          ),
        ),
        Text(" x "),
        Text(widget.activeTypeValue[index].abs().toString())
      ],
    );
  }

  Widget listTypeShow(String operator) {
    return Center(
      child: GridView.count(
        childAspectRatio: 4.5,
        crossAxisCount: 2,
        shrinkWrap: true,
        children: List.generate(widget.activeTypeString.length, (index) {
          return Container(
            margin: EdgeInsets.only(left: 30),
            child: createTypeTag(index),
          );
        }),
      ),
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
                    height: 20,
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
                    height: 20,
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
                    height: 20,
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
