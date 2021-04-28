import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';

class HiddenMenuWidget extends StatelessWidget {
  /// name of the menu item
  final String name;

  /// callback to recibe action click in item
  final GestureTapCallback? onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle? baseStyle;

  /// style to apply to text when item is selected
  final TextStyle? selectedStyle;

  final bool selected;

  final TypeOpen typeOpen;

  const HiddenMenuWidget({
    Key? key,
    required this.name,
    this.onTap,
    required this.colorLineSelected,
    this.baseStyle,
    this.selectedStyle,
    required this.selected,
    required this.typeOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            if (typeOpen == TypeOpen.FROM_LEFT)
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4.0),
                    bottomRight: Radius.circular(4.0)),
                child: Container(
                  height: 40.0,
                  color: selected ? colorLineSelected : Colors.transparent,
                  width: 5.0,
                ),
              ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: typeOpen == TypeOpen.FROM_LEFT ? 20 : 0.0,
                  right: typeOpen == TypeOpen.FROM_RIGHT ? 20 : 0.0,
                ),
                child: Text(
                  name,
                  style: _getStyle().merge(_getStyleSelected()),
                  textAlign: typeOpen == TypeOpen.FROM_RIGHT
                      ? TextAlign.right
                      : TextAlign.left,
                ),
              ),
            ),
            if (typeOpen == TypeOpen.FROM_RIGHT)
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0)),
                child: Container(
                  height: 40.0,
                  color: selected ? colorLineSelected : Colors.transparent,
                  width: 5.0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  TextStyle? _getStyleSelected() {
    return this.selected
        ? this.selectedStyle ?? TextStyle(color: Colors.white)
        : null;
  }

  TextStyle _getStyle() {
    return this.baseStyle ?? TextStyle(color: Colors.grey, fontSize: 25.0);
  }
}
