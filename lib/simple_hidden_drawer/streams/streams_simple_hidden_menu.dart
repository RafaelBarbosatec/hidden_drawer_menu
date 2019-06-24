import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';

class StreamsSimpleHiddenMenu {
  /// stream used to control item selected
  StreamController<int> _positionSelectedController =
      StreamController<int>.broadcast();
  Function(int) get setPositionSelected => _positionSelectedController.sink.add;
  Stream<int> get getpositionSelected => _positionSelectedController.stream;

  /// stream used to control screen selected
  StreamController<Widget> _screenSelectedController =
      StreamController<Widget>();
  Function(Widget) get setScreenSelected => _screenSelectedController.sink.add;
  Stream<Widget> get getScreenSelected => _screenSelectedController.stream;

  /// stream used to control animation
  StreamController<void> _actionToggleController = StreamController();
  Function(void) get setActionToggle => _actionToggleController.sink.add;
  Stream get getActionToggle => _actionToggleController.stream;

  /// stream used to control animation
  StreamController<MenuState> _menuStateController = StreamController();
  Function(MenuState) get setMenuState => _menuStateController.sink.add;
  Stream get getMenuState => _menuStateController.stream;

  dispose() {
    _screenSelectedController.close();
    _positionSelectedController.close();
    _actionToggleController.close();
    _menuStateController.close();
  }
}
