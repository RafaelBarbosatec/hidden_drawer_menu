import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';

class SimpleHiddenDrawerProvider extends InheritedWidget {
  final SimpleHiddenMenuBloc hiddenDrawerBloc;

  SimpleHiddenDrawerProvider({
    Key key,
    @required this.hiddenDrawerBloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SimpleHiddenMenuBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SimpleHiddenDrawerProvider) as SimpleHiddenDrawerProvider)
          .hiddenDrawerBloc;
}