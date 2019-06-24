import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Center(
        child: Text("Screen 2",
            style: TextStyle(color: Colors.white, fontSize: 30.0)),
      ),
    );
  }
}