import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/streams/streams_simple_hidden_menu.dart';

class SimpleHiddenDrawerBloc {

  /// builder containing the drawer settings
  final int _initPositionSelected;
  final Widget Function(int position , SimpleHiddenDrawerBloc bloc) _screenSelectedBuilder;

  StreamsSimpleHiddenMenu controllers = new StreamsSimpleHiddenMenu();

  bool _startDrag = false;
  bool _isFirstPositionSelected = true;
  int positionStected = 0;

  SimpleHiddenDrawerBloc(this._initPositionSelected, this._screenSelectedBuilder) {

    controllers.getpositionSelected.listen((position) {

      if(position != positionStected || _isFirstPositionSelected) {

        positionStected = position;
        _setScreen(position);

        if (!_startDrag && !_isFirstPositionSelected) {
          toggle();
        }

      }else{
        toggle();
      }

      _isFirstPositionSelected = false;

    });

    controllers.setPositionSelected(_initPositionSelected);

  }

  dispose() {
    controllers.dispose();
  }

  void toggle() {
    controllers.setActionToggle(null);
  }

  void setSelectedMenuPosition(int position){
    controllers.setPositionSelected(position);
  }

  int getPositionSelected(){
    return positionStected;
  }

  Stream<int> getPositionSelectedListern(){
    return controllers.getpositionSelected;
  }

  Stream<MenuState> getMenuStateListern(){
    return controllers.getMenuState;
  }

  _setScreen(int position) {
    Widget screen = _screenSelectedBuilder(position,this);
    if(screen != null){
      controllers.setScreenSelected(screen);
    }
  }

}