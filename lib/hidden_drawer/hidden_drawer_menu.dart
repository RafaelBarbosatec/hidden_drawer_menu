library hidden_drawer_menu;

export 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
export 'package:hidden_drawer_menu/menu/hidden_menu.dart';
export 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
export 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';
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

  ///Change iconmenu of the AppBar
  final Widget iconMenuAppBar;

  /// Add actions in the AppBar
  final List<Widget> actionsAppBar;

  /// Set custom widget in tittleAppBar
  final Widget tittleAppBar;

  /// Decide whether title is centered or not
  final bool isTitleCentered;

  //Menu
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage backgroundMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color backgroundColorMenu;

  /// that allows us to add shadow above menu items
  final bool enableShadowItensMenu;

  /// enable and disable open and close with gesture
  final bool isDraggable;

  final Curve curveAnimation;

  final double slidePercent;

  /// percent the content should scale vertically
  final double verticalScalePercent;

  /// radius applied to the content when active
  final double contentCornerRadius;

  /// anable animation Scale
  final bool enableScaleAnimin;

  /// anable animation borderRadius
  final bool enableCornerAnimin;

  final TypeOpen typeOpen;

  final Widget title;

  HiddenDrawerMenu({
    this.screens,
    this.initPositionSelected = 0,
    this.backgroundColorAppBar,
    this.elevationAppBar = 4.0,
    this.iconMenuAppBar = const Icon(Icons.menu),
    this.backgroundMenu,
    this.backgroundColorMenu,
    this.backgroundColorContent = Colors.white,
    this.whithAutoTittleName = true,
    this.styleAutoTittleName,
    this.actionsAppBar,
    this.tittleAppBar,
    this.isTitleCentered,
    this.enableShadowItensMenu = false,
    this.curveAnimation = Curves.decelerate,
    this.isDraggable = true,
    this.slidePercent = 80.0,
    this.verticalScalePercent = 80.0,
    this.contentCornerRadius = 10.0,
    this.enableScaleAnimin = true,
    this.enableCornerAnimin = true,
    this.typeOpen = TypeOpen.FROM_LEFT,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      isDraggable: isDraggable,
      curveAnimation: curveAnimation,
      slidePercent: slidePercent,
      verticalScalePercent: verticalScalePercent,
      contentCornerRadius: contentCornerRadius,
      enableCornerAnimin: enableCornerAnimin,
      enableScaleAnimin: enableScaleAnimin,
      menu: buildMenu(),
      typeOpen: typeOpen,
      initPositionSelected: initPositionSelected,
      title: title,
      screenSelectedBuilder: (position, bloc) {
        List<Widget> actions = List();

        if (typeOpen == TypeOpen.FROM_RIGHT) 
        {
          actions.add(
            IconButton(
              icon: iconMenuAppBar,
              onPressed: () {
                bloc.toggle();
              },
            ),
          );
        }

        if (actionsAppBar != null) {
          actions.addAll(actionsAppBar);
        }

        return Scaffold(
          backgroundColor: backgroundColorContent,
          appBar: screens[position].itemMenu.hideAppBar
              ? null
              : AppBar(
                  backgroundColor:
                      screens[position].itemMenu.appBarColor != null
                          ? screens[position].itemMenu.appBarColor
                          : backgroundColorAppBar,
                  elevation: elevationAppBar,
                  title: getTittleAppBar(position),
                  centerTitle: isTitleCentered,
                  leading: _buildLeading(bloc),
                  actions: actions,
                ),
          body: screens[position].screen,
        );
      },
    );
  }

  getTittleAppBar(int position) {
    if (tittleAppBar == null) {
      return whithAutoTittleName
          ? Text(
              screens[position].itemMenu.name,
              style: styleAutoTittleName,
            )
          : Container();
    } else {
      return tittleAppBar;
    }
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
      typeOpen: typeOpen,
      title: title,
    );
  }

  Widget _buildLeading(SimpleHiddenDrawerBloc bloc) {
    if (typeOpen == TypeOpen.FROM_LEFT) {
      return IconButton(
          icon: iconMenuAppBar,
          onPressed: () {
            bloc.toggle();
          });
    } else {
      return null;
    }
  }
}
