import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/builder/hidden_drawer_builder.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/providers/BlocProvider.dart';

class HiddenDrawerMenu extends StatelessWidget {

  final HiddenDrawerMenuBuilder hiddenDrawer;

  HiddenDrawerMenu({Key key, this.hiddenDrawer}) : super(key: key);

  HiddenDrawerMenuBloc bloc;
  Curve scaleDownCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<HiddenDrawerMenuBloc>(context);

    return Stack(
      children: [
        StreamBuilder(
          stream: bloc.listItensMenu.stream,
          initialData: new List<ItemHiddenMenu>(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data.length > 0) {
              return HiddenMenu(
                itens: snapshot.data,
                background: hiddenDrawer.backgroundMenu,
                backgroundColorMenu: hiddenDrawer.backgroundColorMenu,
                initPositionSelected: hiddenDrawer.initPositionSelected,
                enableShadowItensMenu: hiddenDrawer.enableShadowItensMenu,
                selectedListern: (position) {
                  bloc.clickItemPositionMenu(position);
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
          image: hiddenDrawer.backgroundContent,
          color: hiddenDrawer.backgroundColorContent),
      child: new Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: hiddenDrawer.backgroundColorAppBar,
          elevation: hiddenDrawer.elevationAppBar,
          title: getTittleAppBar(),
          leading: new IconButton(
              icon: hiddenDrawer.iconMenuAppBar,
              onPressed: () {
                bloc.toggle();
              }),
          actions: hiddenDrawer.actionsAppBar,
        ),
        body: StreamBuilder(
            stream: bloc.screenSelected.stream,
            initialData: Container(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data;
            }),
      ),
    ));
  }

  animateContent(Widget content) {
    return StreamBuilder(
        stream: bloc.contollerAnimation.stream,
        initialData: new HiddenDrawerController(vsync: bloc.vsync),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var slidePercent, scalePercent;
          var _controller = snapshot.data;

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
                  child: content),
            ),
          );
        });
  }

  getTittleAppBar() {
    if (hiddenDrawer.tittleAppBar == null) {
      return StreamBuilder(
          stream: bloc.tittleAppBar.stream,
          initialData: "",
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return hiddenDrawer.whithAutoTittleName
                ? Text(
                    snapshot.data,
                    style: hiddenDrawer.styleAutoTittleName,
                  )
                : Container();
          });
    } else {
      return hiddenDrawer.tittleAppBar;
    }
  }
}
