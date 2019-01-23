import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/provider/HiddenDrawerProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ScreenHiddenDrawer> itens = new List();

  @override
  void initState() {
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Screen 1",
          colorTextUnSelected: Colors.white.withOpacity(0.5),
          colorLineSelected: Colors.teal,
//        colorTextSelected: Colors.teal,
        ),
        Container(
          color: Colors.teal,
          child: Center(
            child: Text("Screen 1",
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
          ),
        )));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Screen 2",
          colorTextUnSelected: Colors.white.withOpacity(0.5),
          colorLineSelected: Colors.orange,
//         colorTextSelected: Colors.orange,
        ),
        SecondSreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      whithAutoTittleName: true,
      menu: SecondSreen(),
      screenSelectedBuilder: (position){
        if(position == 0){
          return Container(
            color: Colors.red,
          );
        }else{
          return Container(
            color: Colors.green,
          );
        }
      },
      tittleSelectedBuilder: (position){

      },
    );
  }
}

class SecondSreen extends StatefulWidget {
  @override
  _SecondSreenState createState() => _SecondSreenState();
}

class _SecondSreenState extends State<SecondSreen> {
  @override
  Widget build(BuildContext context) {
    print("SecondSreen build");
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.cyan,
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                SimpleHiddenDrawerProvider.of(context).selectedMenuPosition(0);
              },
              child: Text("Menu 1"),
            ),
            RaisedButton(
                onPressed: () {
                  SimpleHiddenDrawerProvider.of(context).selectedMenuPosition(1);
                },
                child: Text("Menu 2"))
          ],
        ),
      ),
    );
  }
}
