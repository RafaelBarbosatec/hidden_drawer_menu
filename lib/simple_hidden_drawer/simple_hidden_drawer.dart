import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/AnimatedDrawerContent.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';

class SimpleHiddenDrawer extends StatefulWidget {

  /// position initial item selected in menu( start in 0)
  final int initPositionSelected;

  /// Decocator that allows us to add backgroud in the content(color)
  final Color backgroundColorContent;

  //AppBar
  /// enable auto title in appbar with menu item name
  final bool whithAutoTittleName;

  /// Style of the title in appbar
  final TextStyle styleAutoTittleName;

  /// change backgroundColor of the AppBar
  final Color backgroundColorAppBar;

  ///Change elevation of the AppBar
  final double elevationAppBar;

  ///Change iconmenu of the AppBar
  final Widget iconMenuAppBar;

  /// Add actions in the AppBar
  final List<Widget> actionsAppBar;

  /// Set custom widget in tittleAppBar
  final Widget tittleAppBar;

  /// enable and disable open and close with gesture
  final bool isDraggable;

  /// curve effect to open and close drawer
  final Curve curveAnimation;

  /// Function of the recive screen to show
  final Widget Function(int position) screenSelectedBuilder;

  /// Function of the recive tittle to show
  final String Function(int position) tittleSelectedBuilder;

  final Widget menu;

  const SimpleHiddenDrawer({
    Key key,
    this.initPositionSelected = 0,
    this.backgroundColorContent = Colors.white,
    this.whithAutoTittleName = false,
    this.styleAutoTittleName,
    this.backgroundColorAppBar,
    this.elevationAppBar = 4.0,
    this.iconMenuAppBar = const Icon(Icons.menu),
    this.actionsAppBar,
    this.tittleAppBar,
    this.isDraggable = true,
    this.curveAnimation = Curves.decelerate,
    this.screenSelectedBuilder,
    this.tittleSelectedBuilder,
    this.menu
  }) : assert(screenSelectedBuilder != null, tittleSelectedBuilder != null), super(key: key);
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
      _bloc = SimpleHiddenDrawerBloc(widget.initPositionSelected,widget.screenSelectedBuilder, widget.tittleSelectedBuilder);
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
      controller:_controller,
      isDraggable: widget.isDraggable,
      child: Scaffold(
        backgroundColor: widget.backgroundColorContent,
        appBar: AppBar(
          backgroundColor: widget.backgroundColorAppBar,
          elevation: widget.elevationAppBar,
          title: getTittleAppBar(),
          leading: new IconButton(
              icon: widget.iconMenuAppBar,
              onPressed: () {
                _bloc.toggle();
              }),
          actions: widget.actionsAppBar,
        ),
        body: StreamBuilder(
            stream: _bloc.controllers.getScreenSelected,
            initialData: Container(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data;
            }),
      ),
    );
  }

  getTittleAppBar() {
    if (widget.tittleAppBar == null) {
      return StreamBuilder(
          stream: _bloc.controllers.getTittleAppBar,
          initialData: "",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return widget.whithAutoTittleName
                ? Text(
              snapshot.data,
              style: widget.styleAutoTittleName,
            )
                : Container();
          });
    } else {
      return widget.tittleAppBar;
    }
  }

  void initControllerAnimation() {

    _controller = new HiddenDrawerController(
      vsync: this,
      animationCurve: widget.curveAnimation
    );

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
