import 'package:flutter/widgets.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/streams/streams_simple_hidden_menu.dart';

class SimpleHiddenDrawerBloc {

  /// builder containing the drawer settings
  final int _initPositionSelected;
  final Widget Function(int position) _screenSelectedBuilder;
  final String Function(int position) _tittleSelectedBuilder;

  StreamsSimpleHiddenMenu controllers = new StreamsSimpleHiddenMenu();

  double _actualPositionDrag = 0;
  bool _startDrag = false;
  bool _isFirstPositionSelected = true;
  int positionStected = 0;

  SimpleHiddenDrawerBloc(this._initPositionSelected, this._screenSelectedBuilder, this._tittleSelectedBuilder) {

    controllers.getpositionSelected.listen((position) {

      if(position != positionStected || _isFirstPositionSelected) {
        positionStected = position;
        _setTittle(position);
        _setScreen(position);

        if (!_startDrag && !_isFirstPositionSelected) {
          toggle();
        }
      }

      _isFirstPositionSelected = false;

    });

    controllers.getDragHorizontal.listen((position){
      _startDrag = true;
      _actualPositionDrag = position;
      controllers.setPercentAnimate(position);
    });

    controllers.getEndDrag.listen((v){
      if(_startDrag) {
        controllers.setpositionActualEndDrag(_actualPositionDrag);
        _startDrag = false;
      }
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

  Stream getPositionSelectedListern(){
    return controllers.getpositionSelected;
  }

  _setTittle(int position) {
    String title = _tittleSelectedBuilder(position);
    if(title != null){
      controllers.setTittleAppBar(title);
    }
  }

  _setScreen(int position) {
    Widget screen = _screenSelectedBuilder(position);
    if(screen != null){
      controllers.setScreenSelected(screen);
    }
  }

}