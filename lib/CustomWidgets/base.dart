import 'package:flutter/material.dart';

import 'drawer.dart';

class BaseWidget extends StatelessWidget {
  final List<Widget> children;
  const BaseWidget({Key? key, required this.children}) : super(key: key);

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
        ],
      ),
    );
  }
}
