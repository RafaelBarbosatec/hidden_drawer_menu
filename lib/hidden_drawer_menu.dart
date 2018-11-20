library hidden_drawer_menu;

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/screen_hidden_drawer.dart';

class HiddenDrawerMenu extends StatefulWidget {
  final List<ScreenHiddenDrawer> screens;
  final int initPositionSelected;
  final DecorationImage backgroundContent;
  final Color backgroundColorContent;
  final bool whithAutoTittleName;
  final TextStyle styleAutoTittleName;

  //AppBar
  final Color backgroundColorAppBar;
  final double elevationAppBar;
  final Widget iconMenuAppBar;
  final List<Widget> actionsAppBar;
  final Widget tittleAppBar;

  //Menu
  final DecorationImage backgroundMenu;
  final Color backgroundColorMenu;
  final bool enableShadowItensMenu;

  HiddenDrawerMenu(
      {Key key,
      this.screens,
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
        this.enableShadowItensMenu = false})
      : assert(
            screens.length > 0 && initPositionSelected <= (screens.length - 1)),
        super(key: key);

  @override
  _HiddenDrawerMenuState createState() => _HiddenDrawerMenuState();
}

class _HiddenDrawerMenuState extends State<HiddenDrawerMenu>
    with TickerProviderStateMixin {
  List<ItemHiddenMenu> itensMenu = new List();
  int positionSelected;
  HiddenDrawerController _controller;
  Curve scaleDownCurve = new Interval(0.0, 0.8, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();

    positionSelected = widget.initPositionSelected;

    _controller = new HiddenDrawerController(
      vsync: this,
    )..addListener(() => setState(() {}));

    widget.screens.forEach((f) {
      itensMenu.add(f.itemMenu);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HiddenMenu(
          itens: itensMenu,
          background: widget.backgroundMenu,
          backgroundColorMenu: widget.backgroundColorMenu,
          initPositionSelected: widget.initPositionSelected,
          enableShadowItensMenu: widget.enableShadowItensMenu,
          selectedListern: (position) {
            if (position != positionSelected) {
              positionSelected = position;
              _controller.toggle();
            }
          },
        ),
        createContentDisplay()
      ],
    );
  }

  createContentDisplay() {
    return animateContent(Container(
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
                _controller.toggle();
              }),
          actions: widget.actionsAppBar,
        ),
        body: widget.screens[positionSelected].screen,
      ),
    ));
  }

  animateContent(Widget content) {

    var slidePercent, scalePercent;

    switch (_controller.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(_controller.percentOpen);
        scalePercent = scaleDownCurve.transform(_controller.percentOpen);
        break;
      case MenuState.closing:
        slidePercent = slideInCurve.transform(_controller.percentOpen);
        scalePercent = scaleUpCurve.transform(_controller.percentOpen);
        break;
    }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final contentPerspective = 0.4 * _controller.percentOpen;
    final cornerRadius = 10.0 * _controller.percentOpen;

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
            child: content
        ),
      ),
    );
  }

  getTittleAppBar() {
    if (widget.tittleAppBar == null) {
      return widget.whithAutoTittleName
          ? Text(
              widget.screens[positionSelected].itemMenu.name,
              style: widget.styleAutoTittleName,
            )
          : Container();
    } else {
      return widget.tittleAppBar;
    }
  }
}
