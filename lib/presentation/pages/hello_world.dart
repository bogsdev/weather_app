import 'package:flutter/material.dart';
import 'package:weather_app/common/values/labels.dart';

class HelloWorldPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Labels.i.helloWorld),
      ),
      body: Center(
        child: Text(Labels.i.helloWorldWithExclamationPoint),
      ),
    );
  }
}
