import 'package:flutter/material.dart';
import 'package:weather_app/common/values/labels.dart';
import 'package:weather_app/presentation/navigation/routing.dart';

Future<void> showBasicDialog(String title, String message) async {
  await showDialog(
    context: Routing.i.navigatorKey.currentContext,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(Labels.i.ok),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}

Future<void> showLoadingDialog() async {
  await showDialog(
    context: Routing.i.navigatorKey.currentContext,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(Labels.i.loadingWithEllipses),
          ],
        ),
      ),
    ),
  );
}
