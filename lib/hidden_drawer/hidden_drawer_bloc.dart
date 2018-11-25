

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/builder/hidden_drawer_builder.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/providers/BlocProvider.dart';

class HiddenDrawerMenuBloc implements BlocBase{

  @override
  TickerProvider vsync;

  final HiddenDrawerMenuBuilder _hiddenDrawer;

  List<ItemHiddenMenu> itensMenu = new List();
  int _positionSelected;
  HiddenDrawerController _controller;

  HiddenDrawerMenuBloc(this._hiddenDrawer){
    _positionSelected = _hiddenDrawer.initPositionSelected;
    _hiddenDrawer.screens.forEach((f) {
      itensMenu.add(f.itemMenu);
    });
  }

  StreamController<List<ItemHiddenMenu>> listItensMenu;
  StreamController<Widget> screenSelected ;
  StreamController<String> tittleAppBar ;
  StreamController<HiddenDrawerController> contollerAnimation ;
  
  toggle(){

    _controller.toggle();

  }

  clickItemPositionMenu(int position){

    _positionSelected = position;

    tittleAppBar.sink.add(itensMenu[_positionSelected].name);
    screenSelected.sink.add(_hiddenDrawer.screens[_positionSelected].screen);

    toggle();

  }
  
  
  @override
  void didChangeDependencies() {
    
  }

  @override
  void dispose() {
    listItensMenu.close();
    screenSelected.close();
    tittleAppBar.close();
    contollerAnimation.close();
    _controller.close();
  }

  @override
  void initState() {

    contollerAnimation = StreamController<HiddenDrawerController>();

    listItensMenu = StreamController<List<ItemHiddenMenu>>();
    listItensMenu.sink.add(itensMenu);

    tittleAppBar = StreamController<String>();

    screenSelected = StreamController<Widget>();
    screenSelected.sink.add(_hiddenDrawer.screens[_positionSelected].screen);

    _controller = new HiddenDrawerController(
      vsync: vsync,
    )..addListener(() => contollerAnimation.sink.add(_controller) );

  }

}