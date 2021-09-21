import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listItem = [
      {
        'text': 'Pokedex',
        'route': '/home',
        'icon': Icon(Icons.catching_pokemon)
      },
      {
        'text': 'Compare',
        'route': '/compare',
        'icon': Icon(Icons.compare_arrows)
      },
      {
        'text': 'Team Builder',
        'route': '/team_builder',
        'icon': Icon(Icons.build)
      },
      {'text': 'Favourite', 'route': '/favorite', 'icon': Icon(Icons.favorite)},
      {'text': 'About', 'route': '/about', 'icon': Icon(Icons.info)},
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
                      style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 5.0,
                              color: Colors.black,
                            )
                          ]),
                    ),
                    titlePadding: EdgeInsets.only(bottom: 5.0, left: 15.0),
                    centerTitle: false,
                    stretchModes: [StretchMode.zoomBackground],
                    background: Image(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill,
                        image: AssetImage(
                            'assets/images/shapes/red_rectangle.jpg')),
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
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(bottom: 30),
      child: IconButton(
        iconSize: 35,
        icon: const Icon(Icons.menu),
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
