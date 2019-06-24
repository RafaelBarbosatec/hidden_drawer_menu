import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';

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

  /// anable animation Scale
  final bool enableScaleAnimin;

  /// anable animation borderRadius
  final bool enableCornerAnimin;

  /// Function of the recive screen to show
  final Widget Function(int position, SimpleHiddenDrawerBloc bloc) screenSelectedBuilder;

  final Widget menu;

  final TypeOpen typeOpen;

  const SimpleHiddenDrawer({
    Key key,
    this.initPositionSelected = 0,
    this.isDraggable = true,
    this.slidePercent = 80.0,
    this.verticalScalePercent = 80.0,
    this.contentCornerRadius = 10.0,
    this.curveAnimation = Curves.decelerate,
    this.screenSelectedBuilder,
    this.menu,
    this.enableScaleAnimin = true,
    this.enableCornerAnimin = true,
    this.typeOpen = TypeOpen.FROM_LEFT,
  }) :  assert(screenSelectedBuilder != null),
        assert(menu != null),super(key: key);
  @override
  _SimpleHiddenDrawerState createState() => _SimpleHiddenDrawerState();
}

class _SimpleHiddenDrawerState extends State<SimpleHiddenDrawer> with TickerProviderStateMixin {

  SimpleHiddenDrawerBloc _bloc;

  /// controller responsible to animation of the drawer
  HiddenDrawerController _controller;

  @override
  Widget build(BuildContext context) {

    if(_bloc == null) {
      _bloc = SimpleHiddenDrawerBloc(widget.initPositionSelected,widget.screenSelectedBuilder);
      initControllerAnimation();
    }

    return SimpleHiddenDrawerProvider(
      hiddenDrawerBloc: _bloc,
      child: buildLayout(),
    );
  }

  Widget buildLayout() {
    return Stack(
      children: [
        widget.menu,
        createContentDisplay()
      ],
    );
  }

  createContentDisplay() {
    return AnimatedDrawerContent(
      whithPaddingTop: true,
      controller:_controller,
      isDraggable: widget.isDraggable,
      slidePercent: widget.slidePercent,
      verticalScalePercent: widget.verticalScalePercent,
      contentCornerRadius: widget.contentCornerRadius,
      enableScaleAnimin: widget.enableScaleAnimin,
      enableCornerAnimin: widget.enableCornerAnimin,
      typeOpen: widget.typeOpen,
      child: StreamBuilder(
          stream: _bloc.controllers.getScreenSelected,
          initialData: Container(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.data;
          }),
    );
  }

  void initControllerAnimation() {

    _controller = new HiddenDrawerController(
      vsync: this,
      animationCurve: widget.curveAnimation
    );

    _controller.addListener((){
      _bloc.controllers.setMenuState(_controller.state);
    });

    _bloc.controllers.getActionToggle.listen((d){
      _controller.toggle();
    });

  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

}
