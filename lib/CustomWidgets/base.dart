import 'package:flutter/material.dart';

import 'drawer.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [child, DrawerButton()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
