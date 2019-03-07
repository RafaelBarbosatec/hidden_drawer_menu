
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';

class AnimatedDrawerContent extends StatefulWidget {

  final HiddenDrawerController controller;
  final Widget child;
  final bool isDraggable;
  final bool whiPaddingTop;

  const AnimatedDrawerContent({Key key, this.controller, this.child, this.isDraggable = true, this.whiPaddingTop = true}) : super(key: key);

  @override
  _AnimatedDrawerContentState createState() => _AnimatedDrawerContentState();
}

class _AnimatedDrawerContentState extends State<AnimatedDrawerContent> {

  double animatePercent = 0.0;
  final double _widthGestureDetector = 30.0;

  @override
  void initState() {
    widget.controller.addListener((){
      setState(() {
        animatePercent = widget.controller.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final slideAmount = 275.0 * animatePercent;
    final contentScale = 1.0 - (0.2 * animatePercent);
    final cornerRadius = 10.0 * animatePercent;

    return Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: const Color(0x44000000),
              offset: const Offset(0.0, 5.0),
              blurRadius: 20.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(cornerRadius),
            child: _buildContet()),
      ),
    );
  }

  _buildContet() {
    return Stack(
      children: <Widget>[
        widget.child,
        Container(
          margin: EdgeInsets.only(top: (widget.whiPaddingTop? 80 : 0)),
          child: GestureDetector(
            onHorizontalDragUpdate:(detail){
              if(widget.isDraggable) {
                var globalPosition = detail.globalPosition.dx;
                if (globalPosition < 0) {
                  globalPosition = 0;
                }
                double position = globalPosition / MediaQuery.of(context).size.width;
                widget.controller.move(position);
              }
            },
            onHorizontalDragEnd:(detail){
              widget.controller.openOrClose();
            },
            child: Container(
              color: Colors.transparent,
              width: _widthGestureDetector,
            ),
          ),
        )
      ],
    );
  }
}
