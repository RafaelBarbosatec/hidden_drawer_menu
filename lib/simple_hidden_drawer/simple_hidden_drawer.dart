import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';
import 'package:hidden_drawer_menu/util/change_notifier_consumer.dart';

class SimpleHiddenDrawer extends StatefulWidget {
  /// position initial item selected in menu( start in 0)
  final int initPositionSelected;

  /// enable and disable open and close with gesture
  final bool isDraggable;

  /// percent the container should be slided to the side
  final double slidePercent;

  /// percent the content should scale vertically
  final double verticalScalePercent;

  /// radius applied to the content when active
  final double contentCornerRadius;

  /// curve effect to open and close drawer
  final Curve curveAnimation;

  /// enable animation Scale
  final bool enableScaleAnimation;

  /// enable animation borderRadius
  final bool enableCornerAnimation;

  /// Function of the receive screen to show
  final AsyncScreenBuilder screenSelectedBuilder;

  final Widget menu;

  final TypeOpen typeOpen;

  /// display shadow on the edge of the drawer
  final bool withShadow;

  const SimpleHiddenDrawer(
      {Key? key,
      this.initPositionSelected = 0,
      this.isDraggable = true,
      this.slidePercent = 80.0,
      this.verticalScalePercent = 80.0,
      this.contentCornerRadius = 10.0,
      this.curveAnimation = Curves.decelerate,
      required this.screenSelectedBuilder,
      required this.menu,
      this.enableScaleAnimation = true,
      this.enableCornerAnimation = true,
      this.typeOpen = TypeOpen.FROM_LEFT,
      this.withShadow = true})
      : super(key: key);
  @override
  _SimpleHiddenDrawerState createState() => _SimpleHiddenDrawerState();
}

class _SimpleHiddenDrawerState extends State<SimpleHiddenDrawer>
    with TickerProviderStateMixin {
  late SimpleHiddenDrawerController _simpleHiddenDrawerController;

  /// controller responsible to animation of the drawer
  late AnimatedDrawerController _animatedDrawerController;

  @override
  void initState() {
    _animatedDrawerController = AnimatedDrawerController(
      vsync: this,
      animationCurve: widget.curveAnimation,
    );

    _simpleHiddenDrawerController = SimpleHiddenDrawerController(
      widget.initPositionSelected,
      _animatedDrawerController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MyProvider(
      controller: _simpleHiddenDrawerController,
      child: Stack(
        children: [
          widget.menu,
          _createContentDisplay(),
        ],
      ),
    );
  }

  Widget _createContentDisplay() {
    return AnimatedDrawerContent(
      withPaddingTop: true,
      controller: _animatedDrawerController,
      isDraggable: widget.isDraggable,
      slidePercent: widget.slidePercent,
      verticalScalePercent: widget.verticalScalePercent,
      contentCornerRadius: widget.contentCornerRadius,
      enableScaleAnimation: widget.enableScaleAnimation,
      enableCornerAnimation: widget.enableCornerAnimation,
      typeOpen: widget.typeOpen,
      withShadow: widget.withShadow,
      child: ChangeNotifierConsumer<SimpleHiddenDrawerController>(
        changeNotifier: _simpleHiddenDrawerController,
        builder: (context, model) {
          return IgnorePointer(
            ignoring: model.state == MenuState.open,
            child: widget.screenSelectedBuilder(
              model.position,
              model,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _simpleHiddenDrawerController.dispose();
    _animatedDrawerController.dispose();
    super.dispose();
  }
}
