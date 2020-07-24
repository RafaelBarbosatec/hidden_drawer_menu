import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';

class SimpleHiddenDrawerProvider extends InheritedWidget {
  final SimpleHiddenDrawerController controller;

  SimpleHiddenDrawerProvider({
    Key key,
    @required this.controller,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SimpleHiddenDrawerController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleHiddenDrawerProvider>()
        .controller;
  }
}
