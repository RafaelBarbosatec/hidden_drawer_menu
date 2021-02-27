import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/controllers/animated_drawer_controller.dart';

enum TypeOpen { FROM_LEFT, FROM_RIGHT }
typedef MatrixBuilder = Matrix4 Function(double animatePercent);

class AnimatedDrawerContent extends StatefulWidget {
  final AnimatedDrawerController controller;
  final Widget child;
  final bool isDraggable;
  final double slidePercent;
  final double verticalScalePercent;
  final double contentCornerRadius;
  final bool withPaddingTop;
  final bool withShadow;
  final bool enableScaleAnimation;
  final bool enableCornerAnimation;
  final TypeOpen typeOpen;
  final MatrixBuilder? matrixBuilder;
  final bool closeOnTap;
  final List<BoxShadow>? boxShadow;
  final MatrixBuilder? matrixBuilder;
  final bool closeOnTap;

  const AnimatedDrawerContent({
    Key? key,
    required this.controller,
    required this.child,
    this.isDraggable = true,
    required this.slidePercent,
    required this.verticalScalePercent,
    required this.contentCornerRadius,
    this.withPaddingTop = false,
    this.withShadow = true,
    this.enableScaleAnimation = true,
    this.enableCornerAnimation = true,
    this.typeOpen = TypeOpen.FROM_LEFT,
    this.boxShadow,
    this.matrixBuilder,
    this.closeOnTap = true,
  }) : super(key: key);

  @override
  _AnimatedDrawerContentState createState() => _AnimatedDrawerContentState();
}

class _AnimatedDrawerContentState extends State<AnimatedDrawerContent> {
  static const double WIDTH_GESTURE = 50.0;
  static const double HEIGHT_APPBAR = 80.0;
  static const double BLUR_SHADOW = 20.0;
  double slideAmount = 0.0;
  double contentScale = 1.0;
  double cornerRadius = 0.0;
  bool dragging = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AnimatedBuilder(
        animation: widget.controller,
        builder: (_, child) {
          var animatePercent = widget.controller.value;
          var matrixBuilder = widget.matrixBuilder;
          Matrix4? matrix;
          if (matrixBuilder == null) {
            slideAmount = ((constraints.maxWidth) / 100 * widget.slidePercent) *
                animatePercent;

            if (widget.enableScaleAnimation)
              contentScale = 1.0 -
                  (((100 - widget.verticalScalePercent) / 100) *
                      animatePercent);

            slideAmount = widget.typeOpen == TypeOpen.FROM_LEFT
                ? slideAmount
                : (-1 * slideAmount);
            matrix = Matrix4.translationValues(slideAmount, 0.0, 0.0)
              ..scale(contentScale, contentScale);
          }
          if (widget.enableCornerAnimation)
            cornerRadius = widget.contentCornerRadius * animatePercent;
          return Transform(
            transform:
                matrixBuilder != null ? matrixBuilder(animatePercent) : matrix!,
            alignment: widget.typeOpen == TypeOpen.FROM_LEFT
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: _getShadow(),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(cornerRadius),
                child: child,
              ),
            ),
          );
        },
        child: _buildContent(constraints),
      );
    });
  }

  Widget _buildContent(BoxConstraints constraints) {
    if (!widget.isDraggable) {
      return widget.child;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragStart: _myOnHorizontalDragStart,
      onHorizontalDragUpdate: (detail) => _myOnHorizontalDragUpdate(
        detail,
        constraints,
      ),
      onHorizontalDragEnd: _myOnHorizontalDragEnd,
      onTap: _myOnTap,
      child: widget.child,
    );
  }

  List<BoxShadow> _getShadow() {
    if (widget.withShadow) {
      return widget.boxShadow ??
          [
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

  void _myOnHorizontalDragStart(DragStartDetails detail) {
    if (detail.localPosition.dx <= WIDTH_GESTURE &&
        !(widget.withPaddingTop && detail.localPosition.dy <= HEIGHT_APPBAR)) {
      this.setState(() {
        dragging = true;
      });
    }
  }

  void _myOnHorizontalDragUpdate(
    DragUpdateDetails detail,
    BoxConstraints constraints,
  ) {
    if (dragging) {
      var globalPosition = detail.globalPosition.dx;
      globalPosition = globalPosition < 0 ? 0 : globalPosition;
      double position = globalPosition / constraints.maxWidth;
      var realPosition =
          widget.typeOpen == TypeOpen.FROM_LEFT ? position : (1 - position);
      widget.controller.move(realPosition);
    }
  }

  void _myOnHorizontalDragEnd(DragEndDetails detail) {
    if (dragging) {
      widget.controller.openOrClose();
      setState(() {
        dragging = false;
      });
    }
  }

  void _myOnTap() {
    if (!widget.closeOnTap) return;
    if (widget.controller.state == MenuState.open) {
      widget.controller.close();
    }
  }
}
