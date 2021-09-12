import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/compare.dart';

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
        CompareScreen(),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Team Builder Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Favourite Here')],
        )),
        Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Character Here')],
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
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "One Pokemon Character Test"),
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
