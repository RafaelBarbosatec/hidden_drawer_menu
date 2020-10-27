import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu_demo/screens/screen1.dart';
import 'package:hidden_drawer_menu_demo/screens/screen2.dart';

class ExampleHiddenDrawer extends StatelessWidget {
  final List<ScreenHiddenDrawer> itens = [
    ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Screen 1",
        colorLineSelected: Colors.teal,
        baseStyle:
            TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 25.0),
        selectedStyle: TextStyle(color: Colors.teal),
      ),
      Screen1(),
    ),
    ScreenHiddenDrawer(
      ItemHiddenMenu(
        name: "Screen 2",
        colorLineSelected: Colors.orange,
        baseStyle:
            TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 25.0),
        selectedStyle: TextStyle(color: Colors.orange),
        onTap: () {
          print("Click item");
        },
      ),
      Screen2(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      initPositionSelected: 0,
      screens: itens,
      backgroundColorMenu: Colors.cyan,
      slidePercent: 50,
//      typeOpen: TypeOpen.FROM_RIGHT,
      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      //    slidePercent: 80.0,
      //    verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0,
      //    iconMenuAppBar: Icon(Icons.menu),
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //    styleAutoTittleName: TextStyle(color: Colors.red),
      //    actionsAppBar: <Widget>[],
      //    backgroundColorContent: Colors.blue,
      //    backgroundColorAppBar: Colors.blue,
      //    elevationAppBar: 4.0,
      //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
      //    enableShadowItemsMenu: true,
      //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
