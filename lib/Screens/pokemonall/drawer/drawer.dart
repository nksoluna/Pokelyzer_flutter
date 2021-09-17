import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelyzer/Screens/Compare/compare.dart';
import 'package:pokelyzer/Screens/Home/home.dart';

class PokemonDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomScrollView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.red,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  stretch: true,
                  pinned: false,
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Pokelyzer",
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black,
                              offset: Offset(5.0, 5.0),
                            )
                          ]),
                    ),
                    titlePadding: EdgeInsets.only(bottom: 10.0, top: 52.0),
                    centerTitle: true,
                    stretchModes: [StretchMode.zoomBackground],
                    background: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.red, Colors.grey],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      /*child: Image(
                          alignment: Alignment.topCenter,
                          image: AssetImage('assets/images/1.png')),*/
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          'Home',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.home_rounded,
                          color: Theme.of(context).accentColor,
                        ),
                        selected: true,
                        onTap: () {
                          selectedpage(context, 0);
                        },
                      ),
                      ListTile(
                        title: Text('Pokemon'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.folder_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          selectedpage(context, 1);
                        },
                      ),
                      ListTile(
                        title: Text('Compare'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.folder_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          selectedpage(context, 2);
                        },
                      ),
                      ListTile(
                        title: Text('Team Builder'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.folder_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          selectedpage(context, 3);
                        },
                      ),
                      ListTile(
                        title: Text('Favorite'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.folder_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          selectedpage(context, 4);
                        },
                      ),
                      ListTile(
                        title: Text('Settings'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.settings_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          // Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             SettingPage(callback: callback)));
                        },
                      ),
                      ListTile(
                        title: Text('About'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.info_outline_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/about');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void selectedpage(BuildContext context, int index) {
  switch (index) {
    case (0):
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      break;
    case (1):
      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => CompareScreen()));
      break;
  }
}
