import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/hidden_drawer_controller.dart';

enum TypeOpen { FROM_LEFT, FROM_RIGHT }

class AnimatedDrawerContent extends StatefulWidget {
  final HiddenDrawerController controller;
  final Widget child;
  final bool isDraggable;
  final double slidePercent;
  final double verticalScalePercent;
  final double contentCornerRadius;
  final bool whithPaddingTop;
  final bool whithShadow;
  final bool enableScaleAnimin;
  final bool enableCornerAnimin;
  final TypeOpen typeOpen;

  const AnimatedDrawerContent(
      {Key key,
      this.controller,
      this.child,
      this.isDraggable = true,
      this.slidePercent,
      this.verticalScalePercent,
      this.contentCornerRadius,
      this.whithPaddingTop = false,
      this.whithShadow = true,
      this.enableScaleAnimin = true,
      this.enableCornerAnimin = true,
      this.typeOpen = TypeOpen.FROM_LEFT})
      : assert(controller != null),
        super(key: key);

  @override
  _AnimatedDrawerContentState createState() => _AnimatedDrawerContentState();
}

class _AnimatedDrawerContentState extends State<AnimatedDrawerContent> {
  static const double WIDTH_GESTURE = 30.0;
  static const double HEIGHT_APPBAR = 80.0;
  static const double BLUR_SHADOW = 20.0;
  RenderBox _box;
  double width = 0;
  double height = 0;
  double slideAmount = 0.0;
  double contentScale = 1.0;
  double cornerRadius = 0.0;
  bool dragging = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) {
        var animatePercent = widget.controller.value;
        slideAmount = ((width) / 100 * widget.slidePercent) * animatePercent;

        if (widget.enableScaleAnimin)
          contentScale = 1.0 -
              (((100 - widget.verticalScalePercent) / 100) * animatePercent);

        if (widget.enableCornerAnimin)
          cornerRadius = widget.contentCornerRadius * animatePercent;

        slideAmount = widget.typeOpen == TypeOpen.FROM_LEFT
            ? slideAmount
            : (-1 * slideAmount);

        return Transform(
          transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
            ..scale(contentScale, contentScale),
          alignment: widget.typeOpen == TypeOpen.FROM_LEFT
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            decoration: new BoxDecoration(
              boxShadow: _getShadow(),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius),
                child: child),
          ),
        );
      },
      child: _buildContet(),
    );
  }

  _buildContet() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,

      onHorizontalDragStart: (detail) {
        if (widget.isDraggable && detail.localPosition.dx <= WIDTH_GESTURE) {
          if (widget.whithPaddingTop && detail.localPosition.dy <= HEIGHT_APPBAR) {
            return;
          }
          this.setState(() {
            dragging = true;
          });
        }
      },

      onHorizontalDragUpdate: (detail) {
        if (dragging) {
          var left = _box.globalToLocal(Offset(0.0, 0.0)).dx;
          var globalPosition = detail.globalPosition.dx + left;
          if (globalPosition < 0) {
            globalPosition = 0;
          }
          double position = globalPosition / (MediaQuery.of(context).size.width + left);
          var realPosition = widget.typeOpen == TypeOpen.FROM_LEFT ? position : (1 - position);
          widget.controller.move(realPosition);
        }
      },

      onHorizontalDragEnd: (detail) {
        if (dragging) {
          widget.controller.openOrClose();
          setState(() {
            dragging = false;
          });
        }
      },

      onTap: () {
        if (widget.controller.state == MenuState.open) {
          widget.controller.close();
        }
      },
      child: widget.child,
    );
  }

  List<BoxShadow> _getShadow() {
    if (widget.whithShadow) {
      return [
        new BoxShadow(
          color: const Color(0x44000000),
          offset: const Offset(0.0, 5.0),
          blurRadius: BLUR_SHADOW,
          spreadRadius: 5.0,
        ),
      ];
    } else {
      return [];
    }
  }

  void _afterLayout(Duration timeStamp) {
    setState(() {
      _box = context.findRenderObject();
      width = _box.size.width;
      height = _box.size.height;
    });
  }
}
