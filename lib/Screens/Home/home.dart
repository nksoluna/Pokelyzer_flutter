import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "./assets/material-image/background-mobile.jpg",
          ),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(20),
                  // crossAxisSpacing: 10,
                  // mainAxisSpacing: 10,
                  children: [
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/all_pokemon');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Pokedex"),
                    ]),
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/all_pokemon');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Compare"),
                    ]),
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/team_builder');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Team Builder"),
                    ]),
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        child: MaterialButton(
                          color: Colors.blue,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/favorite');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Favourite"),
                    ]),
                  ]),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 110,
                  width: 110,
                  child: MaterialButton(
                    color: Colors.blue,
                    shape: CircleBorder(side: BorderSide(color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text("About"),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
