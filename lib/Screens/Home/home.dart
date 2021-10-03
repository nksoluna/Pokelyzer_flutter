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
            "./assets/material-image/home-background-with-rotom.png",
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
                        margin: EdgeInsets.only(bottom: 10),
                        child: MaterialButton(
                          child: Image.asset('assets/icon/pokedex_icon.png'),
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/all_pokemon');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Pokedex",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        margin: EdgeInsets.only(bottom: 10),
                        child: MaterialButton(
                          child: Image.asset('assets/icon/compare_icon.png'),
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/all_pokemon');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Compare",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        margin: EdgeInsets.only(bottom: 10),
                        child: MaterialButton(
                          child:
                              Image.asset('assets/icon/teambuilder_icon.png'),
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/team_builder');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Team Builder",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                    Column(children: [
                      Container(
                        height: 110,
                        width: 110,
                        margin: EdgeInsets.only(bottom: 10),
                        child: MaterialButton(
                          child: Image.asset('assets/icon/fav_icon.png'),
                          color: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(color: Colors.white)),
                          onPressed: () {
                            Navigator.pushNamed(context, '/favorite');
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Favourite",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ]),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 110,
                  width: 110,
                  child: MaterialButton(
                    child: Image.asset('assets/icon/about_icon.png'),
                    color: Colors.white,
                    shape: CircleBorder(side: BorderSide(color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "About",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
