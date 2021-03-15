import 'package:flutter/material.dart';

class ItemHiddenMenu {
  /// name of the menu item
  final String name;

  /// callback to recibe action click in item
  final Function? onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle baseStyle;

  /// style to apply to text when item is selected
  final TextStyle selectedStyle;

  final bool selected;

  ItemHiddenMenu({
    Key? key,
    required this.name,
    this.selected = false,
    this.onTap,
    this.colorLineSelected = Colors.blue,
    required this.baseStyle,
    required this.selectedStyle,
  });
}
