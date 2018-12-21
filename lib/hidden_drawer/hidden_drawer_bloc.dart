import 'package:hidden_drawer_menu/hidden_drawer/StreamsControllers.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';

class HiddenDrawerMenuBloc {

  /// builder containing the drawer settings
  final List<ScreenHiddenDrawer> _screens;
  final int _initPositionSelected;

  /// itens used to list in menu
  List<ItemHiddenMenu> _itensMenu = new List();

  StreamsControllers controllers = new StreamsControllers();

  double _actualPositionDrag = 0;
  bool _startDrag = false;

  HiddenDrawerMenuBloc(this._screens, this._initPositionSelected) {

    _screens.forEach((item) {
      _itensMenu.add(item.itemMenu);
    });

    controllers.setItensMenu(_itensMenu);
    controllers.setTittleAppBar(_itensMenu[_initPositionSelected].name);

    controllers.getpositionSelected.listen((position) {
      controllers.setTittleAppBar(_itensMenu[position].name);
      controllers.setScreenSelected(position);
      toggle();
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

  }

  dispose() {
    controllers.dispose();
  }

  void toggle() {
    controllers.setActionToggle('');
  }

}
