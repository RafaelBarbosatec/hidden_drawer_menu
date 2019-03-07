
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';

class AnimatedContent extends StatefulWidget {

  final HiddenDrawerController controller;
  final Widget child;

  const AnimatedContent({Key key, this.controller, this.child}) : super(key: key);

  @override
  _AnimatedContentState createState() => _AnimatedContentState();
}

class _AnimatedContentState extends State<AnimatedContent> {

  double animatePercent = 0.0;

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
    var contentPerspective = 0.0;
    final cornerRadius = 10.0 * animatePercent;

    contentPerspective = 0.4 * animatePercent;

    return Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..setEntry(3, 2, 0.001)
        ..rotateY(contentPerspective)
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
            child: widget.child),
      ),
    );
  }
}
