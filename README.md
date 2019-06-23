[![pub package](https://img.shields.io/pub/v/hidden_drawer_menu.svg)](https://pub.dartlang.org/packages/hidden_drawer_menu)

# Hidden Drawer Menu

Hidden Drawer Menu is a library for adding a beautiful drawer mode menu feature with perspective animation.

You can use a pre-defined menu or make a fully customized menu.

![Usage of the hidden_drawer_menu widget on an android device](https://github.com/RafaelBarbosatec/hidden_drawer_menu/blob/master/imgs/app2.gif)

# Use with default menu

```Dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ScreenHiddenDrawer> itens = new List();

  @override
  void initState() {
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Screen 1",
          colorTextUnSelected: Colors.white.withOpacity(0.5),
          colorLineSelected: Colors.teal,
        ),
        FirstSreen()));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Screen 2",
          colorTextUnSelected: Colors.white.withOpacity(0.5),
          colorLineSelected: Colors.orange,
        ),
        SecondSreen()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.blueGrey,
      backgroundColorAppBar: Colors.cyan,
      screens: itens,
        //    typeOpen: TypeOpen.FROM_RIGHT,
        //    enableScaleAnimin: true,
        //    enableCornerAnimin: true,
        //    slidePercent: 80.0,
        //    verticalScalePercent: 80.0,
        //    contentCornerRadius: 10.0,
        //    iconMenuAppBar: Icon(Icons.menu),
        //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
        //    whithAutoTittleName: true,
        //    styleAutoTittleName: TextStyle(color: Colors.red),
        //    actionsAppBar: <Widget>[],
        //    backgroundColorContent: Colors.blue,
        //    elevationAppBar: 4.0,
        //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
        //    enableShadowItensMenu: true,
        //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
    
  }
}

```

# Use with full customization menu

```Dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SimpleHiddenDrawer(
        menu: Menu(),
        screenSelectedBuilder: (position,bloc) {
          
          Widget screenCurrent;
          
          switch(position){
            case 0 : screenCurrent = Screen1(); break;
            case 1 : screenCurrent = Screen2(); break;
            case 2 : screenCurrent = Screen3(); break;
          }
          
          return Scaffold(
            backgroundColor: backgroundColorContent,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    bloc.toggle();
                  }),
            ),
            body: screenCurrent,
          );
          
        },
      ),
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _SecondSreenState createState() => _MenuState();
}

class _MenuState extends State<SecondSreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.cyan,
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                SimpleHiddenDrawerProvider.of(context)
                    .setSelectedMenuPosition(0);
              },
              child: Text("Menu 1"),
            ),
            RaisedButton(
                onPressed: () {
                  SimpleHiddenDrawerProvider.of(context)
                      .setSelectedMenuPosition(1);
                },
                child: Text("Menu 2"))
          ],
        ),
      ),
    );
  }
}
```

# Actions
This actions is only accessible by the children of  HiddenDrawerMenu or SimpleHiddenDrawer.

## Select item menu

```Dart
SimpleHiddenDrawerProvider.of(context).setSelectedMenuPosition(0);
```

## Toggle menu (if opened will close, if closed will open)

```Dart
SimpleHiddenDrawerProvider.of(context).toggle();
```

## Listern position selected in menu

```Dart
SimpleHiddenDrawerProvider.of(context).getPositionSelectedListern().listen((position){
  print(position);
});
```
## If you want to use only the widget responsible for the animation, it is now available as AnimatedDrawerContent

![Example usage AnimatedDrawerContent](https://github.com/RafaelBarbosatec/hidden_drawer_menu/blob/develop/imgs/exampleAnimated.gif)

```Dart
HiddenDrawerController controller = HiddenDrawerController(vsync: this);

return AnimatedDrawerContent(
  controller: controller,
  whithPaddingTop: false, //(optional) default = false // Add padding top in de gesture equals Heigth of the AppBar
  whithShadow: false, //(optional) default = false
  isDraggable: true, //(optional) default = true
  child: Screen(),
);
```
You can control actions by controller such as:

```Dart
controller.toggle() // Open or Close
controller.open()
controller.close()
controller.move(percent) // moves to a specific position from 0 to 1 (0 = fully enclosed, 1 = fully opened)
```


# Available settings

## Menu
* change BackgroundColor
* set DecorationImage backgroud
* enable Shadow above itens

## Itens Menu
* change colorText when selected
* change colorText when unselected
* change color lineleft selected

## AppBar
* change menu icon
* change elavation
* change BackgroundColor
* set AutoTittleName
* set actions
* set widget in tittleAppBar

## Content
* change BackgroundColor
* enable dragable
* change curve animation
