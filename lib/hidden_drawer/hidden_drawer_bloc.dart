import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/builder/hidden_drawer_builder.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/providers/bloc_provider.dart';

class HiddenDrawerMenuBloc implements BlocBase {

  @override
  TickerProvider vsync;

  /// builder containing the drawer settings
  final HiddenDrawerMenuBuilder _hiddenDrawer;

  /// itens used to list in menu
  List<ItemHiddenMenu> itensMenu = new List();

  /// controller responsible to animation of the drawer
  HiddenDrawerController _controller;

  HiddenDrawerMenuBloc(this._hiddenDrawer) {

    _hiddenDrawer.screens.forEach((item) {
      itensMenu.add(item.itemMenu);
    });

  }

  /// stream used to control item selected
  StreamController<int> positionSelected;

  /// stream used to control in view itens of the menu
  StreamController<List<ItemHiddenMenu>> listItensMenu;

  /// stream used to control screen selected
  StreamController<Widget> screenSelected;

  /// stream used to control title
  StreamController<String> tittleAppBar;

  /// stream used to control animation
  StreamController<HiddenDrawerController> contollerAnimation;

  toggle() {
    _controller.toggle();
  }

  @override
  void didChangeDependencies() {}

  @override
  void dispose() {
    listItensMenu.close();
    screenSelected.close();
    tittleAppBar.close();
    contollerAnimation.close();
    positionSelected.close();
    _controller.close();
  }

  @override
  void initState() {

    initStreamsControllers();

    initControllerAnimation();

  }

  /// initialize all Streams controllers
  void initStreamsControllers() {
    contollerAnimation = StreamController<HiddenDrawerController>();

    listItensMenu = StreamController<List<ItemHiddenMenu>>();
    listItensMenu.sink.add(itensMenu);

    tittleAppBar = StreamController<String>();
    tittleAppBar.sink.add(itensMenu[_hiddenDrawer.initPositionSelected].name);

    screenSelected = StreamController<Widget>();
    screenSelected.sink
        .add(_hiddenDrawer.screens[_hiddenDrawer.initPositionSelected].screen);

    positionSelected = StreamController<int>();

    positionSelected.stream.listen((position) {
      tittleAppBar.sink.add(itensMenu[position].name);
      screenSelected.sink.add(_hiddenDrawer.screens[position].screen);

      toggle();
    });
  }

  /// initialize controler animation
  void initControllerAnimation() {
    _controller = new HiddenDrawerController(
      vsync: vsync,
    )..addListener(() => contollerAnimation.sink.add(_controller));
  }

}
