import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);

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
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  stretch: true,
                  pinned: false,
                  expandedHeight: MediaQuery.of(context).size.height * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      "Pokelyzer",
                      style: TextStyle(fontSize: 30.0, color: Colors.red),
                    ),
                    titlePadding: EdgeInsets.only(bottom: 40.0),
                    centerTitle: true,
                    stretchModes: [StretchMode.zoomBackground],
                    background: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image(
                          alignment: Alignment.topCenter,
                          image: AssetImage('assets/images/1.png')),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      ListTile(
                        title: Text(
                          'Pokedex',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(Icons.data_usage),
                        selected: true,
                        onTap: () {
                          Navigator.pop(context);
                          if (route != null && route.settings.name != '/home') {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                      ),
                      ListTile(
                        title: Text('Compare'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(
                          Icons.search,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          if (route != null &&
                              route.settings.name != '/compare') {
                            Navigator.pushNamed(context, '/compare');
                          }
                        },
                      ),
                      ListTile(
                        title: Text('Team Builder'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(Icons.add),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Favourite'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(Icons.favorite),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Character'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(Icons.person),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Settings'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                        leading: Icon(Icons.settings_rounded),
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
                          // Navigator.pushNamed(context, '/about');
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

class DrawerButton extends StatelessWidget {
  const DrawerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, left: 4.0),
      child: IconButton(
        icon: const Icon(
          Icons.horizontal_split_rounded,
          size: 50,
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? null
            : Colors.grey[700],
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
      ),
    );
  }
}
