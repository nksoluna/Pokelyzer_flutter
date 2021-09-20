import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        widget.propertiesToShow == "Strength"
            ? Column(
                children: [
                  Text("Strengths"),
                  Column(
                    children: List.generate(18, (index) {
                      if (widget.properties[index] > 0) {
                        return Text(allTypeString[index] +
                            " x " +
                            widget.properties[index].toString());
                      } else
                        return SizedBox();
                    }),
                  ),
                ],
              )
            : SizedBox(),
        widget.propertiesToShow == "Weakness"
            ? Column(
                children: [
                  Text("Weakness"),
                  Column(
                    children: List.generate(18, (index) {
                      if (widget.properties[index] < 0) {
                        return Text(allTypeString[index] +
                            " x " +
                            widget.properties[index].toString());
                      } else
                        return SizedBox();
                    }),
                  ),
                ],
              )
            : SizedBox(),
        widget.propertiesToShow == "Immune"
            ? Column(
                children: [
                  Text("Immune"),
                  Column(
                    children: List.generate(18, (index) {
                      if (widget.properties[index] > 0) {
                        return Text(allTypeString[index] +
                            " x " +
                            widget.properties[index].toString());
                      } else
                        return SizedBox();
                    }),
                  ),
                ],
              )
            : SizedBox()
      ]),
    );
  }
}
