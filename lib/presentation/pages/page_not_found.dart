import 'package:flutter/material.dart';
import 'package:weather_app/common/values/labels.dart';

class PageNotFound extends StatelessWidget {
  final String path;

  PageNotFound({this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(Labels.i.appTitle)),
      ),
      body: Center(
        child: Text('${Labels.i.pageNotFoundColon} ${path ?? ""}'),
      ),
    );
  }
}
