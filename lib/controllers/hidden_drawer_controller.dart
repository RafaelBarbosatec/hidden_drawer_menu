import 'package:flutter/material.dart';

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

class HiddenDrawerController extends ChangeNotifier {

  /// provider used to animation
  final TickerProvider vsync;

  /// animationController used to animation of the drawer
  final AnimationController _animationController;

  double value = 0.0;

  /// used to control of the state of the drawer
  MenuState state = MenuState.closed;

  HiddenDrawerController(this.vsync, animationDuration)
      : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      // TODO: How to make this animation duration configurable? Defaults to 250, I like it better at 120
      ..duration = Duration(milliseconds: animationDuration)
      ..addListener(() {
        value = _animationController.value;
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            value = 1.0;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            value = 0.0;
            break;
        }
        notifyListeners();
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// channel to access percent of the animation
  get percentOpen {
    return _animationController.value;
  }

  ///method to open drawer
  open([double percent = 0.0]) {
    _animationController.forward(from: percent);
  }

  ///method to close drawer
  close([double percent = 1.0]) {
    _animationController.reverse(from: percent);
  }

  ///method to change state of the drawer
  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}
