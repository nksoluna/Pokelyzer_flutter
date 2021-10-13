import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'drawer.dart';

class BaseWidget extends StatelessWidget {
  final List<Widget> children;
  final List<Widget>? panelBody;
  final List<String>? tabBar;
  final double panelRadius;
  PanelController? panelController;

  BaseWidget({
    Key? key,
    required this.children,
    this.panelBody,
    this.panelController,
    this.tabBar,
    this.panelRadius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Stack(
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
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [DrawerButton()]..addAll(children)),
            ),
          ),
          buildSlidingUpPannel(),
        ],
      ),
    );
  }

  Widget buildSlidingUpPannel() {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(panelRadius),
      topRight: Radius.circular(panelRadius),
    );
    if (panelBody != null) {
      return SlidingUpPanel(
        renderPanelSheet: false,
        controller: panelController,
        borderRadius: radius,
        panel: DefaultTabController(
          length: tabBar!.length,
          child: GestureDetector(
            onTap: () => panelController!.open(),
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: 100,
                  height: 8,
                ),
                shape: RoundedRectangleBorder(borderRadius: radius),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: List.generate(
                      tabBar!.length, (index) => Tab(text: tabBar![index])),
                ),
              ),
              body: TabBarView(
                children: panelBody!,
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox();
  }
}
