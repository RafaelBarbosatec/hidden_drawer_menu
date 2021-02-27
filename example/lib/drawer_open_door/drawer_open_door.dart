import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu_demo/screens/screen1.dart';
import 'package:hidden_drawer_menu_demo/screens/screen2.dart';

class HiddenDrawerDoorExample extends StatelessWidget {
  final List<ScreenHiddenDrawer> items = [
    ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Screen 1",
        colorLineSelected: Colors.teal,
        baseStyle:
            TextStyle(color: Colors.lightBlue.withOpacity(0.5), fontSize: 25.0),
        selectedStyle: TextStyle(color: Colors.teal),
      ),
      Screen1(),
    ),
    ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Screen 2",
        colorLineSelected: Colors.teal,
        baseStyle:
            TextStyle(color: Colors.lightBlue.withOpacity(0.5), fontSize: 25.0),
        selectedStyle: TextStyle(color: Colors.teal),
        onTap: () {
          print("Click item");
        },
      ),
      Screen2(),
    )
  ];
  Matrix4 _pmat(num pv) {
    return new Matrix4(
      1.0, 0.0, 0.0, 0.0, //
      0.0, 1.0, 0.0, 0.0, //
      0.0, 0.0, 1.0, pv * 0.001, //
      0.0, 0.0, 0.0, 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: items,
      backgroundColorMenu: Colors.transparent,
      slidePercent: 50,
      matrixBuilder: (double val) {
        print(val);
        var scaleDown = 0.85;
        return _pmat(1.1)
          ..scale(lerpDouble(1, scaleDown, val), lerpDouble(1, scaleDown, val))
          ..translate(width, 0.0)
          ..multiply(Matrix4.rotationY((pi * 65 / 180) * val))
          ..translate(
              -width + lerpDouble(0.0, ((1.1 - scaleDown) * width), val));
        // ..rotateY(-(pi * 45 / 180) * val) ..translate(val * -width, 0.0);
      },
      animatedBagroundBuilder: (controller) => AnimatedBuilder(
        animation: controller,
        builder: (_, child) => Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment
                  .centerRight, // 10% of the width, so there are ten blinds.
              colors: [Colors.white, Colors.black],
              stops: [0, controller.value]),
        )),
      ),
      contentCornerRadius: 25,
      enableCornerAnimation: true,
      isDraggable: false,closeOnTap: true,
      //      typeOpen: TypeOpen.FROM_RIGHT,    enableScaleAnimin: true,
      // enableCornerAnimin: true,    slidePercent: 80.0,    verticalScalePercent:
      // 80.0,    contentCornerRadius: 10.0,    iconMenuAppBar: Icon(Icons.menu),
      // backgroundContent: DecorationImage((image:
      // ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      // whithAutoTittleName: true,    styleAutoTittleName: TextStyle(color:
      // Colors.red),    actionsAppBar: <Widget>[],  backgroundColorContent:
      // Colors.red,    backgroundColorAppBar: Colors.blue,    elevationAppBar: 4.0,
      //  tittleAppBar: Center(child: Icon(Icons.ac_unit),),    enableShadowItensMenu:
      // true,    backgroundMenu: DecorationImage(image:
      // ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
