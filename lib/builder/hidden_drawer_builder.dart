import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu_2.dart';
import 'package:hidden_drawer_menu/providers/BlocProvider.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';

class HiddenDrawerMenuBuilder {

  final List<ScreenHiddenDrawer> screens;
  final int initPositionSelected;
  final DecorationImage backgroundContent;
  final Color backgroundColorContent;
  final bool whithAutoTittleName;
  final TextStyle styleAutoTittleName;

  //AppBar
  final Color backgroundColorAppBar;
  final double elevationAppBar;
  final Widget iconMenuAppBar;
  final List<Widget> actionsAppBar;
  final Widget tittleAppBar;

  //Menu
  final DecorationImage backgroundMenu;
  final Color backgroundColorMenu;
  final bool enableShadowItensMenu;

  HiddenDrawerMenuBuilder(
      { this.screens,
        this.initPositionSelected = 0,
        this.backgroundColorAppBar,
        this.elevationAppBar = 4.0,
        this.iconMenuAppBar = const Icon(Icons.menu),
        this.backgroundMenu,
        this.backgroundColorMenu,
        this.backgroundContent,
        this.backgroundColorContent = Colors.white,
        this.whithAutoTittleName = true,
        this.styleAutoTittleName,
        this.actionsAppBar,
        this.tittleAppBar,
        this.enableShadowItensMenu = false});

  Widget build() {
    return BlocProvider<HiddenDrawerMenuBloc>(
      bloc: HiddenDrawerMenuBloc(this),
      child: HiddenDrawerMenu2(hiddenDrawer:this)
    );
  }
}
