import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu_demo/exampleCustomMenu/ExampleCustomMenu.dart';
import 'package:hidden_drawer_menu_demo/exampleHiddenDrawer/example_hidden_drawer.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.0)
                    )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExampleHiddenDrawer()),
                  );
                },
                child: Text(
                  "Default Example",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200.0,
              child: RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(20.0)
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExampleCustomMenu()),
                    );
                  },
                  child: Text(
                    "Custom Menu Drawer",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

}
