import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      child: Center(
        child: Text("Screen 1",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
    );
  }
}
