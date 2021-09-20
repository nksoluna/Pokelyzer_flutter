import 'package:flutter/widgets.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/searchFunction.dart';

class SearchWidget extends StatefulWidget {
  final List<Pokemon> allPokemon;
  final List<Type> allType;
  SearchWidget(this.allPokemon, this.allType);
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  List<String> allTypeString = getAllTypeInString();
  List<Pokemon> selectedPokemon = [];
  List<bool> selectedTypeArray = [];
  List<Color> typeColor = [];
  late TextEditingController searchIndexController;
  late TextEditingController searchNameController;
  @override
  void initState() {
    super.initState();
    selectedTypeArray = List.filled(18, false);
    searchIndexController = TextEditingController();
    searchNameController = TextEditingController();
    typeColor = Palette().getAllTypeColor();
  }

  @override
  void dispose() {
    super.dispose();
    searchIndexController.dispose();
    searchNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Stack(
          children: [
            Container(
              height: double.infinity,
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "./assets/material-image/background-mobile.jpg",
                ),
                fit: BoxFit.cover,
              )),
            ),
            Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 0, top: 5),
                    child: RawMaterialButton(
                      fillColor: Colors.red[400],
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "<",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    )),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: searchIndexController,
                    decoration: InputDecoration(labelText: 'Enter Index'),
                  ),
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: searchNameController,
                    decoration:
                        InputDecoration(labelText: 'Enter Pokemon Name'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 300,
                  child: Text(
                    "Select Types( Up to 2 type )",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Container(
                    child: Expanded(
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 35,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: selectedTypeArray[index]
                                        ? typeColor[index]
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedTypeArray[index] =
                                              !selectedTypeArray[index];
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          allTypeString[index],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: selectedTypeArray[index]
                                                  ? Colors.white
                                                  : typeColor[index]),
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 35,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    color: selectedTypeArray[index + 9]
                                        ? typeColor[index + 9]
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedTypeArray[index + 9] =
                                              !selectedTypeArray[index + 9];
                                        });
                                      },
                                      child: Center(
                                        child: Text(
                                          allTypeString[index + 9],
                                          style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  selectedTypeArray[index + 9]
                                                      ? Colors.white
                                                      : typeColor[index + 9]),
                                        ),
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ))),
                Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(bottom: 10, right: 10),
                    child: RaisedGradientButton(
                      height: 40,
                      width: 100,
                      gradient: LinearGradient(
                        colors: <Color>[Colors.red[700]!, Colors.red[400]!],
                      ),
                      onPressed: () {
                        setState(() {
                          selectedPokemon = searchPokemon(
                              searchIndexController.text,
                              searchNameController.text,
                              selectedTypeArray,
                              widget.allPokemon,
                              widget.allType);
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchResult(selectedPokemon)));
                      },
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ))
              ],
            ),
          ],
        )),
      ),
    );
  }
}

class SearchResult extends StatefulWidget {
  final List<Pokemon> selectedPokemon;
  const SearchResult(this.selectedPokemon);

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Stack(
        children: [
          // insert bg here
          Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 0, top: 5),
                  child: RawMaterialButton(
                    fillColor: Colors.red[400],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "<",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    padding: EdgeInsets.all(10.0),
                    shape: CircleBorder(),
                  )),
              Divider(
                color: Colors.grey,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: widget.selectedPokemon.length,
                      itemBuilder: (context, index) {
                        return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(
                                    context, widget.selectedPokemon[index]);
                              },
                              leading: Image.asset('assets/images/pokemons/' +
                                  widget.selectedPokemon[index].index
                                      .toString() +
                                  '.png'),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.selectedPokemon[index].name
                                              .contains("-") &&
                                          widget.selectedPokemon[index].name
                                                  .length >=
                                              10
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.selectedPokemon[index].name
                                                  .split("-")[0],
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              ": " +
                                                  widget.selectedPokemon[index]
                                                      .name
                                                      .split("-")[1],
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          widget.selectedPokemon[index].name,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                  widget.selectedPokemon[index].types.length ==
                                          2
                                      ? Row(
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 70,
                                              child: Card(
                                                color: Palette()
                                                    .getSelectedTypeColor(
                                                        widget
                                                            .selectedPokemon[
                                                                index]
                                                            .types[0],
                                                        getAllTypeInString()),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      widget
                                                          .selectedPokemon[
                                                              index]
                                                          .types[0],
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 35,
                                              width: 70,
                                              child: Card(
                                                color: Palette()
                                                    .getSelectedTypeColor(
                                                        widget
                                                            .selectedPokemon[
                                                                index]
                                                            .types[1],
                                                        getAllTypeInString()),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      widget
                                                          .selectedPokemon[
                                                              index]
                                                          .types[1],
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          height: 35,
                                          width: 70,
                                          child: Card(
                                            color: Palette()
                                                .getSelectedTypeColor(
                                                    widget
                                                        .selectedPokemon[index]
                                                        .types[0],
                                                    getAllTypeInString()),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                  widget.selectedPokemon[index]
                                                      .types[0],
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ));
                      })),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      )),
    ));
  }
}
