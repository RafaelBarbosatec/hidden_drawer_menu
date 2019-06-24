import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu_demo/screen1.dart';
import 'package:hidden_drawer_menu_demo/screen2.dart';

class ExampleCustomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleHiddenDrawer(
      menu: Menu(),
      screenSelectedBuilder: (position,controller) {
        Widget screenCurrent;
        switch(position){
          case 0 : screenCurrent = Screen1(); break;
          case 1 : screenCurrent = Screen2(); break;
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  controller.toggle();
                }),
          ),
          body: screenCurrent,
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with TickerProviderStateMixin{

  AnimationController _animationController;
  bool initConfigState = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    confListenerState(context);

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.cyan,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Image.network(
              'https://wallpaperaccess.com/full/529044.jpg',
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: _animationController,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0)
                          )
                        ),
                        onPressed: () {
                          SimpleHiddenDrawerProvider.of(context)
                              .setSelectedMenuPosition(0);
                        },
                        child: Text(
                            "Menu 1",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 200.0,
                      child: RaisedButton(
                        color: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20.0)
                              )
                          ),
                          onPressed: () {
                            SimpleHiddenDrawerProvider.of(context)
                                .setSelectedMenuPosition(1);
                          },
                          child: Text(
                              "Menu 2",
                            style: TextStyle(
                                color: Colors.white
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void confListenerState(BuildContext context) {
    if(!initConfigState){
      initConfigState = true;
      SimpleHiddenDrawerProvider.of(context).getMenuStateListern().listen((state){

        if(state == MenuState.open){
          _animationController.forward();
        }

        if(state == MenuState.closing){
          _animationController.reverse();
        }
      });
    }
  }


}

