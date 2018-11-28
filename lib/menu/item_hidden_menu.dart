

import 'package:flutter/material.dart';

class ItemHiddenMenu extends StatelessWidget {

  /// name of the menu item
  final String name;

  /// callback to recibe action click in item
  final Function onTap;

  /// color used for selected item in line
  final Color colorLineSelected;

  /// color used in text for selected item
  final Color colorTextSelected;

  /// color used in text for unselected item
  final Color colorTextUnSelected;

  ItemHiddenMenu(
      {Key key,
        this.name,
        this.selected = false,
        this.onTap,
        this.colorLineSelected = Colors.blue,
        this.colorTextSelected = Colors.white,
        this.colorTextUnSelected = Colors.grey})
      : super(key: key);

  bool selected = false;

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
              borderRadius: BorderRadius.only(topRight: Radius.circular(4.0),bottomRight: Radius.circular(4.0)),
              child: Container(
                height: 40.0,
                color: selected ? colorLineSelected : Colors.transparent,
                width: 5.0,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  name,
                  style: TextStyle(
                      color: selected ? colorTextSelected : colorTextUnSelected,
                      fontSize: 25.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}