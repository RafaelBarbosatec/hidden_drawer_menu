import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Screen 1",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
            RaisedButton(
              child: Text('Toggle'),
              onPressed: () {
                SimpleHiddenDrawerController.of(context).toggle();
              },
            )
          ],
        ),
      ),
    );
  }
}
