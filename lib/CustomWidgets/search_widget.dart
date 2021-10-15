import 'package:flutter/widgets.dart';
import 'package:pokelyzer/CustomWidgets/raised_gradient_button.dart';
import 'package:pokelyzer/models/pokemon.dart';
import 'package:pokelyzer/models/type_pokemon.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokelyzer/Helpers/palette.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokelyzer/Helpers/search_function.dart';

class SearchWidget extends StatefulWidget {
  final List<Pokemon> allPokemon;
  final List<TypePokemon> allType;
  final Pokemon? previousPokemon;
  SearchWidget(this.previousPokemon, this.allPokemon, this.allType);
  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  List<String> allTypeString = getAllTypeInString();
  List<Pokemon> selectedPokemon = [];
  List<Pokemon> allPokemon = [];
  List<TypePokemon> allType = [];
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
    final allPokemonBox = Hive.box<Pokemon>('allpokemon');
    allPokemon.addAll(allPokemonBox.values);
    final allTypeBox = Hive.box<TypePokemon>('alltype');
    allType.addAll(allTypeBox.values);
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Container(
                        margin: const EdgeInsets.only(right: 20, top: 2),
                        child: RaisedGradientButton(
                            height: 40,
                            width: 130,
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.grey[50]!,
                                Colors.grey[50]!
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchResult(getFavouritePokemon())));
                            },
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Favourite ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.pink[500]),
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.pink[500],
                                ),
                              ],
                            )))),
                  ],
                ),
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
                  child: GridView.count(
                      childAspectRatio: 4.5,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: List.generate(allTypeString.length, (index) {
                        return Center(
                            child: Container(
                                height: 35,
                                width: 120,
                                margin: EdgeInsets.only(
                                  left: index % 2 == 0 ? 20 : 0,
                                  right: index % 2 == 1 ? 20 : 0,
                                  bottom: 10,
                                ),
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
                                )));
                      })),
                )),
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
                              Navigator.pop(context, null);
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
                                  " Remove",
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchResult(selectedPokemon)));
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
