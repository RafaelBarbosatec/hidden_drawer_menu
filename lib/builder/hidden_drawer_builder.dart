import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_bloc.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/providers/bloc_provider.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';

class HiddenDrawerMenuBuilder {


  /// List item menu and respective screens
  final List<ScreenHiddenDrawer> screens;

  /// position initial item selected in menu( sart in 0)
  final int initPositionSelected;

  /// Decocator that allows us to add backgroud in the content(img)
  final DecorationImage backgroundContent;

  /// Decocator that allows us to add backgroud in the content(color)
  final Color backgroundColorContent;

  /// enable auto title in appbar with menu item name
  final bool whithAutoTittleName;

  /// Style of the title in appbar
  final TextStyle styleAutoTittleName;

  //AppBar
  /// change backgroundColor of the AppBar
  final Color backgroundColorAppBar;

  ///Change elevation of the AppBar
  final double elevationAppBar;

  ///Change iconmenu of the AppBar
  final Widget iconMenuAppBar;

  /// Add actions in the AppBar
  final List<Widget> actionsAppBar;

  /// Set custom widget in tittleAppBar
  final Widget tittleAppBar;

  //Menu
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage backgroundMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color backgroundColorMenu;

  /// that allows us to add shadow above menu items
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

}
