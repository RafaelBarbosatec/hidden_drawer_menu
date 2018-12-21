import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';

class HiddenDrawerMenuBloc {

  /// builder containing the drawer settings
  final List<ScreenHiddenDrawer> _screens;
  final int _initPositionSelected;

  /// itens used to list in menu
  List<ItemHiddenMenu> itensMenu = new List();

  /// stream used to control item selected
  StreamController<int> _positionSelectedController = StreamController<int>();
  Function(int) get setPositionSelected => _positionSelectedController.sink.add;
  Stream<int> get getpositionSelected => _positionSelectedController.stream;

  /// stream used to control in view itens of the menu
  StreamController<List<ItemHiddenMenu>> _listItensMenuController =  StreamController<List<ItemHiddenMenu>>();
  Function(List<ItemHiddenMenu>) get setItensMenu => _listItensMenuController.sink.add;
  Stream<List<ItemHiddenMenu>> get getItensMenu => _listItensMenuController.stream;

  /// stream used to control screen selected
  StreamController<int> _screenSelectedController =  StreamController<int>();
  Function(int) get setScreenSelected => _screenSelectedController.sink.add;
  Stream<int> get getScreenSelected => _screenSelectedController.stream;

  /// stream used to control title
  StreamController<String> _tittleAppBarController = StreamController<String>();
  Function(String) get setTittleAppBar => _tittleAppBarController.sink.add;
  Stream<String> get getTittleAppBar => _tittleAppBarController.stream;

  /// stream used to control animation
  StreamController<double> _percentAnimateController = StreamController<double>();
  Function(double) get setPercentAnimate => _percentAnimateController.sink.add;
  Stream<double> get getPercentAnimate => _percentAnimateController.stream;

  /// stream used to control drag axisX
  StreamController<double> _dragHorizontalController = StreamController<double>();
  Function(double) get setDragHorizontal => _dragHorizontalController.sink.add;
  Stream<double> get getDragHorizontal => _dragHorizontalController.stream;

  /// stream used to control endrag
  StreamController<void> _endDragController = StreamController();
  Function(void) get setEndDrag => _endDragController.sink.add;
  Stream get getEndDrag => _endDragController.stream;

  /// stream used to control animation
  StreamController<void> _actionToggleController = StreamController();
  Function(void) get setActionToggle => _actionToggleController.sink.add;
  Stream get getActionToggle => _actionToggleController.stream;

  /// stream used to control endrag
  StreamController<double> _positionActualEndDragController = StreamController();
  Function(double) get setpositionActualEndDrag => _positionActualEndDragController.sink.add;
  Stream get getpositionActualEndDrag => _positionActualEndDragController.stream;

  double _actualPositionDrag = 0;
  bool _startDrag = false;

  HiddenDrawerMenuBloc(this._screens, this._initPositionSelected) {

    _screens.forEach((item) {
      itensMenu.add(item.itemMenu);
    });

    setItensMenu(itensMenu);
    setTittleAppBar(itensMenu[_initPositionSelected].name);

    getpositionSelected.listen((position) {
      setTittleAppBar(itensMenu[position].name);
      setScreenSelected(position);
      toggle();
    });

    getDragHorizontal.listen((position){
      _startDrag = true;
      _actualPositionDrag = position;
      setPercentAnimate(position);
    });

    getEndDrag.listen((v){
      if(_startDrag) {
        setpositionActualEndDrag(_actualPositionDrag);
        _startDrag = false;
      }
    });

  }

  dispose() {
    _listItensMenuController.close();
    _screenSelectedController.close();
    _tittleAppBarController.close();
    _percentAnimateController.close();
    _positionSelectedController.close();
    _dragHorizontalController.close();
    _endDragController.close();
    _actionToggleController.close();
    _positionActualEndDragController.close();
  }

  void toggle() {
    setActionToggle('');
  }

}
