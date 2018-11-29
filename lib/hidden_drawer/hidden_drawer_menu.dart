import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/builder/hidden_drawer_builder.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';


class HiddenDrawerMenu extends StatefulWidget {

  /// builder containing the drawer settings
  final HiddenDrawerMenuBuilder hiddenDrawer;

  /// Curves to animations
  final Curve curveAnimation;

  HiddenDrawerMenu({Key key, this.hiddenDrawer,this.curveAnimation = Curves.decelerate}) : super(key: key);

  @override
  _HiddenDrawerMenuState createState() => _HiddenDrawerMenuState();
}

class _HiddenDrawerMenuState extends State<HiddenDrawerMenu> with TickerProviderStateMixin{

  /// Curves to animations
  Curve _animationCurve;

  /// controlling block
  HiddenDrawerMenuBloc _bloc;

  @override
  void initState() {

    _bloc = HiddenDrawerMenuBloc(widget.hiddenDrawer,this);
    _animationCurve = new Interval(0.0, 1.0, curve: widget.curveAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        StreamBuilder(
          stream: _bloc.listItensMenu.stream,
          initialData: new List<ItemHiddenMenu>(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data.length > 0) {
              return HiddenMenu(
                itens: snapshot.data,
                background: widget.hiddenDrawer.backgroundMenu,
                backgroundColorMenu: widget.hiddenDrawer.backgroundColorMenu,
                initPositionSelected: widget.hiddenDrawer.initPositionSelected,
                enableShadowItensMenu: widget.hiddenDrawer.enableShadowItensMenu,
                selectedListern: (position) {
                  _bloc.positionSelected.sink.add(position);
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
    return animateContent(Container(
      decoration: BoxDecoration(
          image: widget.hiddenDrawer.backgroundContent,
          color: widget.hiddenDrawer.backgroundColorContent),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: widget.hiddenDrawer.backgroundColorAppBar,
          elevation: widget.hiddenDrawer.elevationAppBar,
          title: getTittleAppBar(),
          leading: new IconButton(
              icon: widget.hiddenDrawer.iconMenuAppBar,
              onPressed: () {
                _bloc.toggle();
              }),
          actions: widget.hiddenDrawer.actionsAppBar,
        ),
        body: StreamBuilder(
            stream: _bloc.screenSelected.stream,
            initialData: Container(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data;
            }),
      ),
    ));
  }

  animateContent(Widget content) {
    return StreamBuilder(
        stream: _bloc.contollerAnimation.stream,
        initialData: new HiddenDrawerController(vsync: this),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var animatePercent;
          var _controller = snapshot.data;

          switch (_controller.state) {
            case MenuState.closed:
              animatePercent = 0.0;
              break;
            case MenuState.open:
              animatePercent = 1.0;
              break;
            case MenuState.opening:
              animatePercent = _animationCurve.transform(_controller.percentOpen);
              break;
            case MenuState.closing:
              animatePercent = _animationCurve.transform(_controller.percentOpen);
              break;
          }

          final slideAmount = 275.0 * animatePercent;
          final contentScale = 1.0 - (0.2 * animatePercent);
          final contentPerspective = 0.4 * animatePercent;
          final cornerRadius = 10.0 * animatePercent;

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
    if (widget.hiddenDrawer.tittleAppBar == null) {
      return StreamBuilder(
          stream: _bloc.tittleAppBar.stream,
          initialData: "",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return widget.hiddenDrawer.whithAutoTittleName
                ? Text(
              snapshot.data,
              style: widget.hiddenDrawer.styleAutoTittleName,
            )
                : Container();
          });
    } else {
      return widget.hiddenDrawer.tittleAppBar;
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

}
