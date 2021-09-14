import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listItem = [
      {'text': 'Pokedex', 'route': '/home', 'icon': Icon(Icons.data_usage)},
      {'text': 'Compare', 'route': '/compare', 'icon': Icon(Icons.search)},
      {
        'text': 'Team Builder',
        'route': '/team_builder',
        'icon': Icon(Icons.add)
      },
      {'text': 'Favourite', 'route': '/favorite', 'icon': Icon(Icons.favorite)},
      {'text': 'Character', 'route': '/character', 'icon': Icon(Icons.person)},
      {
        'text': 'Settings',
        'route': '/setting',
        'icon': Icon(Icons.settings_rounded)
      },
      {
        'text': 'About',
        'route': '/about',
        'icon': Icon(Icons.info_outline_rounded)
      },
    ];

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
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return getlistTile(
                        text: listItem[index]['text']!,
                        route: listItem[index]['route']!,
                        icon: listItem[index]['icon']!);
                  }, childCount: listItem.length),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getlistTile(
      {required String text, required String route, required Icon icon}) {
    return Builder(builder: (context) {
      var currentRoute = ModalRoute.of(context)!;
      bool isSelect = (currentRoute.settings.name == route);

      return ListTile(
        title: Text(text,
            style: TextStyle(
              color: isSelect
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColorDark,
            )),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
        leading: icon,
        selected: isSelect,
        onTap: () {
          Navigator.pop(context);
          if (!isSelect) {
            //pushReplacementNamed will execute the enter animation
            Navigator.pushReplacementNamed(context, route);
          }
        },
      );
    });
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
