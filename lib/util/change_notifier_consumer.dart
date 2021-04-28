import 'package:flutter/material.dart';

typedef ChangeNotifierWidgetBuilder<T extends ChangeNotifier> = Widget Function(
    BuildContext context, T model);

class ChangeNotifierConsumer<T extends ChangeNotifier> extends StatefulWidget {
  final T changeNotifier;
  final ChangeNotifierWidgetBuilder<T> builder;

  ChangeNotifierConsumer({
    Key? key,
    required this.changeNotifier,
    required this.builder,
  }) : super(key: key);
  @override
  _ChangeNotifierConsumerState<T> createState() =>
      _ChangeNotifierConsumerState<T>();
}

class _ChangeNotifierConsumerState<T extends ChangeNotifier>
    extends State<ChangeNotifierConsumer> {
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
    return notifierConsumerWidget.builder(
        context, notifierConsumerWidget.changeNotifier);
  }

  void _listener() {
    setState(() {});
  }

  ChangeNotifierConsumer<T> get notifierConsumerWidget {
    return widget as ChangeNotifierConsumer<T>;
  }
}
