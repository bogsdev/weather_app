import 'package:flutter/material.dart';

class ScrollableSandwich extends StatelessWidget {
  const ScrollableSandwich(
      {Key key, @required this.child, this.header, this.footer})
      : super(key: key);
  final Widget child;
  final Widget header;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      header ?? Container(),
                      Expanded(child: child),
                      footer ?? Container(),
                    ]),
              )));
    });
  }
}
