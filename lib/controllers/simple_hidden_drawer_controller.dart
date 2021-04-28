import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';

typedef AsyncScreenBuilder<T> = Widget Function(
  int position,
  SimpleHiddenDrawerController controller,
);

class SimpleHiddenDrawerController extends ChangeNotifier {
  final AnimatedDrawerController _animatedDrawerController;
  int position = 0;
  MenuState state = MenuState.closed;

  SimpleHiddenDrawerController(
    int initPosition,
    this._animatedDrawerController,
  ) {
    position = initPosition;
    _animatedDrawerController.addListener(() {
      if (state != _animatedDrawerController.state) {
        state = _animatedDrawerController.state;
        notifyListeners();
      }
    });
  }

  void toggle() {
    _animatedDrawerController.toggle();
  }

  void open() {
    if (state != MenuState.open) {
      _animatedDrawerController.open();
    }
  }

  void close() {
    if (state != MenuState.closed) {
      _animatedDrawerController.close();
    }
  }

  void setSelectedMenuPosition(int position, {bool openMenu = true}) {
    this.position = position;
    if (openMenu) {
      toggle();
    }
    notifyListeners();
  }

  int getPositionSelected() {
    return position;
  }

  static SimpleHiddenDrawerController of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyProvider>()!.controller;
  }
}
