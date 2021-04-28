library hidden_drawer_menu;

import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:hidden_drawer_menu/menu/hidden_menu.dart';
import 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';

export 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';
export 'package:hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
export 'package:hidden_drawer_menu/menu/hidden_menu.dart';
export 'package:hidden_drawer_menu/model/item_hidden_menu.dart';
export 'package:hidden_drawer_menu/model/screen_hidden_drawer.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/provider/simple_hidden_drawer_provider.dart';
export 'package:hidden_drawer_menu/simple_hidden_drawer/simple_hidden_drawer.dart';

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
  final TextStyle? styleAutoTittleName;

  /// change backgroundColor of the AppBar
  final Color? backgroundColorAppBar;

  ///Change elevation of the AppBar
  final double elevationAppBar;

  ///Change leading of the AppBar
  final Widget leadingAppBar;

  /// Add actions in the AppBar
  final List<Widget>? actionsAppBar;

  /// Set custom widget in tittleAppBar
  final Widget? tittleAppBar;

  /// Decide whether title is centered or not
  final bool? isTitleCentered;

  //Menu
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage? backgroundMenu;

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

  /// enable animation Scale
  final bool enableScaleAnimation;

  /// enable animation borderRadius
  final bool enableCornerAnimation;

  final bool disableAppBarDefault;

  final TypeOpen typeOpen;

  HiddenDrawerMenu({
    required this.screens,
    this.initPositionSelected = 0,
    this.backgroundColorAppBar,
    this.elevationAppBar = 4.0,
    this.leadingAppBar = const Icon(Icons.menu),
    this.backgroundMenu,
    required this.backgroundColorMenu,
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
    this.enableScaleAnimation = true,
    this.enableCornerAnimation = true,
    this.disableAppBarDefault = false,
    this.typeOpen = TypeOpen.FROM_LEFT,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      isDraggable: isDraggable,
      curveAnimation: curveAnimation,
      slidePercent: slidePercent,
      verticalScalePercent: verticalScalePercent,
      contentCornerRadius: contentCornerRadius,
      enableCornerAnimation: enableCornerAnimation,
      enableScaleAnimation: enableScaleAnimation,
      menu: _buildMenu(),
      typeOpen: typeOpen,
      initPositionSelected: initPositionSelected,
      screenSelectedBuilder: (position, bloc) {
        return Scaffold(
          backgroundColor: backgroundColorContent,
          appBar: _getAppbar(position, bloc),
          body: screens[position].screen,
        );
      },
    );
  }

  Widget? getTittleAppBar(int position) {
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

  Widget _buildMenu() {
    List<ItemHiddenMenu> _itensMenu = [];

    screens.forEach((item) {
      _itensMenu.add(item.itemMenu);
    });

    return HiddenMenu(
      items: _itensMenu,
      background: backgroundMenu,
      backgroundColorMenu: backgroundColorMenu,
      initPositionSelected: initPositionSelected,
      enableShadowItemsMenu: enableShadowItensMenu,
      typeOpen: typeOpen,
    );
  }

  Widget _buildLeading(SimpleHiddenDrawerController bloc) {
    if (typeOpen == TypeOpen.FROM_LEFT) {
      return IconButton(icon: leadingAppBar, onPressed: () => bloc.toggle());
    } else {
      return SizedBox.shrink();
    }
  }

  PreferredSizeWidget? _getAppbar(
    int position,
    SimpleHiddenDrawerController bloc,
  ) {
    if (disableAppBarDefault) return null;

    List<Widget> actions = [];

    if (typeOpen == TypeOpen.FROM_RIGHT) {
      actions.add(
        IconButton(
          icon: leadingAppBar,
          onPressed: () {
            bloc.toggle();
          },
        ),
      );
    }

    if (actionsAppBar != null) {
      actions.addAll(actionsAppBar!);
    }

    return AppBar(
      backgroundColor: backgroundColorAppBar,
      elevation: elevationAppBar,
      title: getTittleAppBar(position),
      centerTitle: isTitleCentered,
      leading: _buildLeading(bloc),
      actions: actions,
    );
  }
}
