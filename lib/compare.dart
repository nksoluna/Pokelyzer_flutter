import 'package:flutter/material.dart';
import 'pokelyzer.dart';

class CompareScreen extends StatefulWidget {
  CompareScreen({Key? key}) : super(key: key);

  @override
  _CompareScreenState createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        drawer: Drawer(
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
                              'Home',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            leading: Icon(
                              Icons.home_rounded,
                              color: Theme.of(context).accentColor,
                            ),
                            selected: true,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Pokemon'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            leading: Icon(
                              Icons.folder_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Compare'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            leading: Icon(
                              Icons.folder_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Team Builder'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            leading: Icon(
                              Icons.folder_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Favorite'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                            leading: Icon(
                              Icons.folder_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text('Settings'),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20.0),
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
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Center(child: Text('Compare Screen')),
                    Builder(
                      builder: (context) => Padding(
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
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
