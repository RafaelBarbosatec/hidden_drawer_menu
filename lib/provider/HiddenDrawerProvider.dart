import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';

class HiddenDrawerMenuProvider extends InheritedWidget {
  final HiddenDrawerMenuBloc hiddenDrawerMenuBloc;

  HiddenDrawerMenuProvider({
    Key key,
    @required this.hiddenDrawerMenuBloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HiddenDrawerMenuBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(HiddenDrawerMenuProvider) as HiddenDrawerMenuProvider)
          .hiddenDrawerMenuBloc;
}