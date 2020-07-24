import 'package:flutter/material.dart';

typedef ChangeNotifierWidgetBuilder<T extends ChangeNotifier> = Widget Function(
    BuildContext context, T model);

// ignore: must_be_immutable
class ChangeNotifierConsumer<T extends ChangeNotifier> extends StatefulWidget {
  final T changeNotifier;
  final ChangeNotifierWidgetBuilder<T> builder;
  ChangeNotifierWidgetBuilder<T> _builderInner;

  ChangeNotifierConsumer({Key key, this.changeNotifier, this.builder})
      : super(key: key) {
    _builderInner = (BuildContext context, ChangeNotifier snapshot) {
      return builder(context, snapshot);
    };
  }
  @override
  _ChangeNotifierConsumerState createState() => _ChangeNotifierConsumerState();
}

class _ChangeNotifierConsumerState extends State<ChangeNotifierConsumer> {
  @override
  void initState() {
    widget.changeNotifier.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.changeNotifier.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget._builderInner(context, widget.changeNotifier);
  }

  void _listener() {
    setState(() {});
  }
}
