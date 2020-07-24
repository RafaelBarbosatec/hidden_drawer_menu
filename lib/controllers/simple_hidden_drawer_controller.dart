import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';

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

  void setSelectedMenuPosition(int position) {
    this.position = position;
    toggle();
    notifyListeners();
  }

  int getPositionSelected() {
    return position;
  }
}
