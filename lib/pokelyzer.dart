import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pokelyzer extends StatefulWidget {
  @override
  PokelyzerState createState() => PokelyzerState();
}

class PokelyzerState extends State<Pokelyzer> {
  int _currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentindex, children: [
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Pokedex Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Compare Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Team Builder Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Favourite Here')],
        ))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentindex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.data_usage),
              label: "Pokedex",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Compare"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Team Builder"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourite"),
        ],
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
      ),
    );
  }
}
