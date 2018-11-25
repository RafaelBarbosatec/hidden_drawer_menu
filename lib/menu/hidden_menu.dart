import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';

class HiddenMenu extends StatefulWidget {

  final DecorationImage background;
  final bool enableShadowItensMenu;
  final Color backgroundColorMenu;
  final List<ItemHiddenMenu> itens;
  final Function(int) selectedListern;
  final int initPositionSelected;

  HiddenMenu(
      {Key key,
      this.background,
      this.itens,
      this.selectedListern,
      this.initPositionSelected,
      this.backgroundColorMenu,
        this.enableShadowItensMenu = false})
      : super(key: key);

  @override
  _HiddenMenuState createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  int indexSelected;

  @override
  void initState() {
    indexSelected = widget.initPositionSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("build _HiddenMenuState");

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: widget.background,
          color: widget.backgroundColorMenu,
        ),
        child: Center(
            child: Container(
              padding: EdgeInsets.only(top: 40.0,bottom: 40.0),
              decoration: BoxDecoration(
                  boxShadow: widget.enableShadowItensMenu ? [
                    new BoxShadow(
                      color: const Color(0x44000000),
                      offset: const Offset(0.0, 5.0),
                      blurRadius: 50.0,
                      spreadRadius: 30.0,
                    ),
                  ]: []
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0.0),
                  itemCount: widget.itens.length,
                  itemBuilder: (context, index) {

                    return new ItemHiddenMenu(
                      name: widget.itens[index].name,
                      selected: index == indexSelected,
                      colorLineSelected: widget.itens[index].colorLineSelected,
                      colorTextSelected: widget.itens[index].colorTextSelected,
                      colorTextUnSelected: widget.itens[index].colorTextUnSelected,
                      onTap: () {
                        if (index != indexSelected) {
                          setState(() {
                            indexSelected = index;
                            widget.selectedListern(index);
                          });
                        }
                      },
                    );

                  }),
            ),
          ),
        ),
    );
  }
}
