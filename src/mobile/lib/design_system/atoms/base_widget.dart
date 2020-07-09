import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final T model;
  final Widget child;
  final Function onModelReady;

  BaseWidget({Key key, this.model, this.builder, this.child, this.onModelReady}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BaseWidgetState<T>();
}

class _BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T model;

  @override
  void didChangeDependencies() {
    model = widget.model;

    if (widget.onModelReady != null) {
      widget.onModelReady();
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: widget.builder,
      child: widget.child,
    );
  }
}
