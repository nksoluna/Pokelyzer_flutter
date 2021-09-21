import 'package:flutter/widgets.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/Helpers/searchFunction.dart';

class FilterWidget extends StatefulWidget {
  final List<Pokemon?> previousPokemon;
  final List<Pokemon> allPokemon;
  final List<Type> allType;
  FilterWidget(this.previousPokemon, this.allPokemon, this.allType);
  @override
  FilterWidgetState createState() => FilterWidgetState();
}

class FilterWidgetState extends State<FilterWidget> {
  List<String> allTypeString = getAllTypeInString();
  List<Pokemon> selectedPokemon = [];
  List<Pokemon> allPokemon = [];
  List<Type> allType = [];
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
    allPokemon = widget.allPokemon;
    allType = widget.allType;
    if (allPokemon.length <= 0) {
      readData();
    }
  }

  Future<void> readData() async {
    allPokemon = await PokemonsRepo().readAllPokemonFromJson();
    allType = await readAllTypeFromJson();
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
                        Navigator.pop(context, widget.previousPokemon);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10, right: 10),
                        child: RaisedGradientButton(
                            height: 40,
                            width: 130,
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.red[700]!,
                                Colors.red[400]!
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                selectedTypeArray = List.filled(18, false);
                                searchIndexController.clear();
                                searchNameController.clear();
                              });
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.highlight_remove,
                                  color: Colors.white,
                                ),
                                Text(
                                  " Clear",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            )))),
                    Container(
                        margin: const EdgeInsets.only(bottom: 10, right: 10),
                        child: RaisedGradientButton(
                            height: 40,
                            width: 130,
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.red[700]!,
                                Colors.red[400]!
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                selectedPokemon = searchPokemon(
                                    searchIndexController.text,
                                    searchNameController.text,
                                    selectedTypeArray,
                                    allPokemon,
                                    allType);
                              });
                              if (selectedPokemon.isEmpty)
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        contentPadding:
                                            EdgeInsets.only(top: 20),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error_outline),
                                            Text(
                                              " Pokemon(s) not found!",
                                              style: (TextStyle(fontSize: 20)),
                                            )
                                          ],
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color(0xFFd93d40)),
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0),
                                                          side: BorderSide(
                                                              color:
                                                                  Colors.red)))),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Back"))
                                        ],
                                      );
                                    });
                              else
                                Navigator.pop(context, selectedPokemon);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search, color: Colors.white),
                                Text(
                                  " Search",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ],
                            ))),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
