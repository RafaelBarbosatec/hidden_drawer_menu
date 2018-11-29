import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';

class HiddenDrawerMenuBloc {

  /// builder containing the drawer settings
  final HiddenDrawerMenu _hiddenDrawer;
  final TickerProvider vsync;

  /// controller responsible to animation of the drawer
  HiddenDrawerController _controller;

  /// itens used to list in menu
  List<ItemHiddenMenu> itensMenu = new List();

  /// stream used to control item selected
  StreamController<int> positionSelected = StreamController<int>();

  /// stream used to control in view itens of the menu
  StreamController<List<ItemHiddenMenu>> listItensMenu =  StreamController<List<ItemHiddenMenu>>();

  /// stream used to control screen selected
  StreamController<Widget> screenSelected =  StreamController<Widget>();

  /// stream used to control title
  StreamController<String> tittleAppBar = StreamController<String>();

  /// stream used to control animation
  StreamController<HiddenDrawerController> contollerAnimation = StreamController<HiddenDrawerController>();

  HiddenDrawerMenuBloc(this._hiddenDrawer, this.vsync) {

    _hiddenDrawer.screens.forEach((item) {
      itensMenu.add(item.itemMenu);
    });

    listItensMenu.sink.add(itensMenu);
    tittleAppBar.sink.add(itensMenu[_hiddenDrawer.initPositionSelected].name);
    screenSelected.sink
        .add(_hiddenDrawer.screens[_hiddenDrawer.initPositionSelected].screen);

    positionSelected.stream.listen((position) {
      tittleAppBar.sink.add(itensMenu[position].name);
      screenSelected.sink.add(_hiddenDrawer.screens[position].screen);

      toggle();
    });

    _controller = new HiddenDrawerController(
      vsync: vsync,
    )..addListener(() => contollerAnimation.sink.add(_controller));

  }

  dispose() {

    listItensMenu.close();
    screenSelected.close();
    tittleAppBar.close();
    contollerAnimation.close();
    positionSelected.close();

  }

  void toggle() {
    _controller.toggle();
  }

}
