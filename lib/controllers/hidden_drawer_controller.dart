import 'package:flutter/material.dart';

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

class HiddenDrawerController extends ChangeNotifier {

  final TickerProvider vsync;
  final AnimationController _animationController;
  MenuState state = MenuState.closed;

  HiddenDrawerController({this.vsync})
      : _animationController = new AnimationController(vsync: vsync) {
    _animationController
      ..duration = const Duration(milliseconds: 250)
      ..addListener(() {
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
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
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

  get percentOpen{
    return _animationController.value;
  }

  open(){
    _animationController.forward();
  }

  close(){
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }

}
