import 'package:flutter/material.dart';

class ItemHiddenMenu extends StatelessWidget {
  /// name of the menu item
  final String name;

  /// callback to recibe action click in item
  final Function onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle baseStyle;

  /// style to apply to text when item is selected
  final TextStyle selectedStyle;

  final bool selected;

  //You need hide the app bar, in some cases like Slives
  final bool hideAppBar;

  //Menu Icon
  final IconData menuIcon;

  //A diferent color for a specific appbar
  final Color appBarColor;

  _getMenuIcon() {
    if (menuIcon != null) {
      return Row(
        children: <Widget>[
          SizedBox(width: 5),
          Icon(
            menuIcon,
            color:
                this.selected ? this.selectedStyle.color : this.baseStyle.color,
          ),
        ],
      );
    }

    return Row();
  }

  ItemHiddenMenu(
      {Key key,
      this.name,
      this.selected = false,
      this.onTap,
      this.colorLineSelected = Colors.blue,
      this.baseStyle,
      this.selectedStyle,
      this.hideAppBar = false,
      this.menuIcon,
      this.appBarColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
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
            _getMenuIcon(),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 20.0),
                  child: Text(
                    name,
                    style: (this.baseStyle ??
                            TextStyle(color: Colors.grey, fontSize: 25.0))
                        .merge(this.selected
                            ? this.selectedStyle ??
                                TextStyle(color: Colors.white)
                            : null),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
