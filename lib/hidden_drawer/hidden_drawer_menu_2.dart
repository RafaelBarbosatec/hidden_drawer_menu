

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/builder/hidden_drawer_builder.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/providers/BlocProvider.dart';

class HiddenDrawerMenu2 extends StatefulWidget {

  final HiddenDrawerMenuBuilder hiddenDrawer;

  HiddenDrawerMenu2({Key key, this.hiddenDrawer}) : super(key: key);

  @override
  _HiddenDrawerMenu2State createState() => _HiddenDrawerMenu2State();
}

class _HiddenDrawerMenu2State extends State<HiddenDrawerMenu2> with TickerProviderStateMixin{

  HiddenDrawerMenuBloc bloc;
  Curve scaleDownCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.of<HiddenDrawerMenuBloc>(context);
    bloc.initController(this);

    print("build _HiddenDrawerMenu2State");

    return Stack(
      children: [
        StreamBuilder(
          stream: bloc.listItensMenu.stream,
          initialData: new List<ItemHiddenMenu>(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if(snapshot.data.length > 0){

              return HiddenMenu(
                itens: snapshot.data,
                background: widget.hiddenDrawer.backgroundMenu,
                backgroundColorMenu: widget.hiddenDrawer.backgroundColorMenu,
                initPositionSelected: widget.hiddenDrawer.initPositionSelected,
                enableShadowItensMenu: widget.hiddenDrawer.enableShadowItensMenu,
                selectedListern: (position) {
                  bloc.clickItemPositionMenu(position);
                },
              );

            }else{
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
                bloc.toggle();
              }),
          actions: widget.hiddenDrawer.actionsAppBar,
        ),
        body: StreamBuilder(
            stream: bloc.screenSelected.stream,
            initialData: Container(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data;
            }
        ),
      ),
    ));
  }

  animateContent(Widget content) {
    return StreamBuilder(
        stream: bloc.contollerAnimation.stream,
        initialData: new HiddenDrawerController(vsync: this),
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
        }
    );
  }

  getTittleAppBar() {
    if (widget.hiddenDrawer.tittleAppBar == null) {

      return StreamBuilder(
        stream: bloc.tittleAppBar.stream,
        initialData: "",
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          return widget.hiddenDrawer.whithAutoTittleName
              ? Text(snapshot.data,
            style: widget.hiddenDrawer.styleAutoTittleName,
          )
              : Container();

        }
      );

    } else {
      return widget.hiddenDrawer.tittleAppBar;
    }
  }

}

