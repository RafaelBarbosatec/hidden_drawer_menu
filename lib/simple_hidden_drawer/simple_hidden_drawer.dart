import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/AnimatedContainer.dart';
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

  /// enable and disable perspective
  final bool enablePerspective;

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
    this.menu,
    this.enablePerspective = false
  }) : assert(screenSelectedBuilder != null, tittleSelectedBuilder != null), super(key: key);
  @override
  _SimpleHiddenDrawerState createState() => _SimpleHiddenDrawerState();
}

class _SimpleHiddenDrawerState extends State<SimpleHiddenDrawer> with TickerProviderStateMixin {

  SimpleHiddenDrawerBloc _bloc;

  /// area access touch gesture in left screnn
  final double _widthGestureDetector = 30.0;

  /// controller responsible to animation of the drawer
  HiddenDrawerController _controller;

  /// Curves to animations
  Curve _animationCurve;

  @override
  void initState() {
    _animationCurve = new Interval(0.0, 1.0, curve: widget.curveAnimation);
    super.initState();
  }

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
    return AnimatedContent(
      controller:_controller,
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
        body: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: _bloc.controllers.getScreenSelected,
                initialData: Container(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data;
                }),
            GestureDetector(
//              onHorizontalDragUpdate:(detail){
//                if(widget.isDraggable) {
//                  var globalPosition = detail.globalPosition.dx;
//                  if (globalPosition < 0) {
//                    globalPosition = 0;
//                  }
//                  double position = globalPosition / constraints.maxWidth;
//                  _bloc.controllers.setDragHorizontal(position);
//                }
//              },
//              onHorizontalDragEnd:(detail){
//                _bloc.controllers.setEndDrag(detail);
//              },
              child: Container(
                color: Colors.transparent,
                width: _widthGestureDetector,
              ),
            )
          ],
        ),
      ),
    );
    return animateContent(LayoutBuilder(
      builder: (context, constraints) =>
      new Scaffold(
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
        body: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: _bloc.controllers.getScreenSelected,
                initialData: Container(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return snapshot.data;
                }),
            GestureDetector(
              onHorizontalDragUpdate:(detail){
                if(widget.isDraggable) {
                  var globalPosition = detail.globalPosition.dx;
                  if (globalPosition < 0) {
                    globalPosition = 0;
                  }
                  double position = globalPosition / constraints.maxWidth;
                  _bloc.controllers.setDragHorizontal(position);
                }
              },
              onHorizontalDragEnd:(detail){
                _bloc.controllers.setEndDrag(detail);
              },
              child: Container(
                color: Colors.transparent,
                width: _widthGestureDetector,
              ),
            )
          ],
        ),
      ),
    ));
  }

  animateContent(Widget content) {
    return StreamBuilder(
        stream: _bloc.controllers.getPercentAnimate,
        initialData: 0.0,
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          var animatePercent = _animationCurve.transform(snapshot.data);

          final slideAmount = 275.0 * animatePercent;
          final contentScale = 1.0 - (0.2 * animatePercent);
          var contentPerspective = 0.0;
          final cornerRadius = 10.0 * animatePercent;

          if(widget.enablePerspective){
            contentPerspective = 0.4 * animatePercent;
          }

          return Transform(
            transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
              ..setEntry(3, 2, 0.001)
              ..rotateY(contentPerspective)
              ..scale(contentScale, contentScale),
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                    color: const Color(0x44000000),
                    offset: const Offset(0.0, 5.0),
                    blurRadius: 20.0,
                    spreadRadius: 5.0,
                  ),
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  child: content),
            ),
          );
        });
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
    )..addListener(() {
      _bloc.controllers.setPercentAnimate(_controller.value);
    });

    _bloc.controllers.getActionToggle.listen((d){
      _controller.toggle();
    });

    _bloc.controllers.getpositionActualEndDrag.listen((p){
      if (p > 0.3) {
        _controller.open(p);
      } else {
        _controller.close(p);
      }
    });

  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

}
