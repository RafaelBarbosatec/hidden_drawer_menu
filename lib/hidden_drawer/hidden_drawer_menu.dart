import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/provider/HiddenDrawerBloc.dart';
import 'package:hidden_drawer_menu/provider/HiddenDrawerProvider.dart';

class HiddenDrawerMenu extends StatefulWidget {
  /// List item menu and respective screens
  final List<ScreenHiddenDrawer> screens;

  /// position initial item selected in menu( sart in 0)
  final int initPositionSelected;

  /// Decocator that allows us to add backgroud in the content(img)
  final DecorationImage backgroundContent;

  /// Decocator that allows us to add backgroud in the content(color)
  final Color backgroundColorContent;

  /// enable auto title in appbar with menu item name
  final bool whithAutoTittleName;

  /// Style of the title in appbar
  final TextStyle styleAutoTittleName;

  //AppBar
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

  //Menu
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage backgroundMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color backgroundColorMenu;

  /// that allows us to add shadow above menu items
  final bool enableShadowItensMenu;

  /// enable and disable open and close with gesture
  final bool isDraggable;

  /// enable and disable perspective
  final bool enablePerspective;

  final Curve curveAnimation;

  HiddenDrawerMenu(
      {this.screens,
      this.initPositionSelected = 0,
      this.backgroundColorAppBar,
      this.elevationAppBar = 4.0,
      this.iconMenuAppBar = const Icon(Icons.menu),
      this.backgroundMenu,
      this.backgroundColorMenu,
      this.backgroundContent,
      this.backgroundColorContent = Colors.white,
      this.whithAutoTittleName = true,
      this.styleAutoTittleName,
      this.actionsAppBar,
      this.tittleAppBar,
      this.enableShadowItensMenu = false,
      this.curveAnimation = Curves.decelerate,
        this.isDraggable = true,
        this.enablePerspective = false});

  @override
  _HiddenDrawerMenuState createState() => _HiddenDrawerMenuState();
}

class _HiddenDrawerMenuState extends State<HiddenDrawerMenu>
    with TickerProviderStateMixin {

  final double _widthGestureDetector = 30.0;

  /// controller responsible to animation of the drawer
  HiddenDrawerController _controller;

  /// Curves to animations
  Curve _animationCurve;

  /// controlling block
  HiddenDrawerMenuBloc _bloc;

  @override
  void initState() {
    _animationCurve = new Interval(0.0, 1.0, curve: widget.curveAnimation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _bloc = HiddenDrawerMenuBloc(widget.screens,widget.initPositionSelected);

    initControllerAnimation();

    return HiddenDrawerMenuProvider(
      hiddenDrawerMenuBloc: _bloc,
      child: buildLayout(),
    );

  }

  Widget buildLayout() {
    return Stack(
      children: [
        StreamBuilder(
          stream: _bloc.controllers.getItensMenu,
          initialData: new List<ItemHiddenMenu>(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data.length > 0) {
              return HiddenMenu(
                itens: snapshot.data,
                background: widget.backgroundMenu,
                backgroundColorMenu: widget.backgroundColorMenu,
                initPositionSelected: widget.initPositionSelected,
                enableShadowItensMenu: widget.enableShadowItensMenu,
                selectedListern: (position) {
                  _bloc.controllers.setPositionSelected(position);
                },
              );
            } else {
              return Container();
            }
          },
        ),
        createContentDisplay()
      ],
    );
  }

  createContentDisplay() {
    return animateContent(LayoutBuilder(
      builder: (context, constraints) =>
          Container(
            decoration: BoxDecoration(
                image: widget.backgroundContent,
                color: widget.backgroundColorContent),
            child: new Scaffold(
              backgroundColor: Colors.transparent,
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
                      initialData: 0,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return widget.screens[snapshot.data].screen;
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
                    spreadRadius: 10.0,
                  ),
                ],
              ),
              child: new ClipRRect(
                  borderRadius: new BorderRadius.circular(cornerRadius),
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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

}