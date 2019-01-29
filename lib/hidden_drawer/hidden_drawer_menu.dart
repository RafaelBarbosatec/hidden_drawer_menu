import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';

class HiddenDrawerMenu extends StatelessWidget {

  /// List item menu and respective screens
  final List<ScreenHiddenDrawer> screens;

  /// position initial item selected in menu( sart in 0)
  final int initPositionSelected;

  /// Decocator that allows us to add backgroud in the content(color)
  final Color backgroundColorContent;

  //AppBar
  /// enable auto title in appbar with menu item name
  final bool whithAutoTittleName;

  /// Style of the title in appbar
  final TextStyle styleAutoTittleName;

  /// change backgroundColor of the AppBar
  final Color backgroundColorAppBar;

  ///Change elevation of the AppBar
  final double elevationAppBar;

  // change the amout the screen should be slided. Defaults to 275.0
  final double slideAmount;

  // change the animation duration
  final int animationDuration;

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

  /// enable and disable open and close with gesture
  final bool isDraggable;

  /// enable and disable perspective
  final bool enablePerspective;

  final Curve curveAnimation;

  HiddenDrawerMenu({
    this.screens,
    this.initPositionSelected = 0,
    this.backgroundColorAppBar,
    this.elevationAppBar = 4.0,
    this.slideAmount = 275.0,
    this.animationDuration = 250,
    this.iconMenuAppBar = const Icon(Icons.menu),
    this.backgroundMenu,
    this.backgroundColorMenu,
    this.backgroundColorContent = Colors.white,
    this.whithAutoTittleName = true,
    this.styleAutoTittleName,
    this.actionsAppBar,
    this.tittleAppBar,
    this.enableShadowItensMenu = false,
    this.curveAnimation = Curves.decelerate,
    this.isDraggable = true,
    this.enablePerspective = false
  });

  @override
  Widget build(BuildContext context) {

    return SimpleHiddenDrawer(
      iconMenuAppBar: iconMenuAppBar,
      initPositionSelected: initPositionSelected,
      backgroundColorAppBar: backgroundColorAppBar,
      elevationAppBar: elevationAppBar,
      slideAmount: slideAmount,
      animationDuration: animationDuration,
      backgroundColorContent: backgroundColorContent,
      whithAutoTittleName:whithAutoTittleName,
      styleAutoTittleName: styleAutoTittleName,
      actionsAppBar: actionsAppBar,
      tittleAppBar: tittleAppBar,
      isDraggable: isDraggable,
      enablePerspective: enablePerspective,
      curveAnimation: curveAnimation,
      menu: buildMenu(),
      screenSelectedBuilder: (position){
        return screens[position].screen;
      },
      tittleSelectedBuilder: (position){
        return screens[position].itemMenu.name;
      },
    );

  }

  buildMenu() {

    List<ItemHiddenMenu> _itensMenu = new List();

    screens.forEach((item) {
      _itensMenu.add(item.itemMenu);
    });

    return HiddenMenu(
      itens: _itensMenu,
      background: backgroundMenu,
      backgroundColorMenu: backgroundColorMenu,
      initPositionSelected: initPositionSelected,
      enableShadowItensMenu: enableShadowItensMenu,
    );
  }

}
