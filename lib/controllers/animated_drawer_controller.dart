import 'package:flutter/material.dart';

enum MenuState {
  closed,
  opening,
  open,
  closing,
}

class AnimatedDrawerController extends ChangeNotifier {
  /// provider used to animation
  final TickerProvider vsync;

  final Curve animationCurve;
  final Duration duration;

  /// animationController used to animation of the drawer
  late AnimationController _animationController;

  late CurvedAnimation _curvedAnimation;

  double value = 0.0;

  double _percent = 0.0;

  /// used to control of the state of the drawer
  MenuState state = MenuState.closed;

  AnimatedDrawerController({
    required this.vsync,
    this.animationCurve = Curves.decelerate,
    this.duration = const Duration(milliseconds: 350),
  }) {
    _initAnimation();
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

  move(double percent) {
    _percent = percent;
    value = animationCurve.transform(percent);
    notifyListeners();
  }

  openOrClose() {
    if (_percent > 0.3) {
      open(_percent);
    } else {
      close(_percent);
    }
  }

  ///method to change state of the drawer
  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }

  void _initAnimation() {
    _animationController = AnimationController(
      vsync: vsync,
      duration: duration,
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: animationCurve,
    );
    _animationController
      ..addListener(() {
        value = _curvedAnimation.value;
        notifyListeners();
      })
      ..addStatusListener(
        (AnimationStatus status) {
          switch (status) {
            case AnimationStatus.forward:
              state = MenuState.opening;
              break;
            case AnimationStatus.reverse:
              state = MenuState.closing;
              break;
            case AnimationStatus.completed:
              state = MenuState.open;
              notifyListeners();
              break;
            case AnimationStatus.dismissed:
              state = MenuState.closed;
              notifyListeners();
              break;
          }
        },
      );
  }
}
