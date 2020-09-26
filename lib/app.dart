import 'package:flutter/material.dart';
import 'package:weather_app/presentation/navigation/routing.dart';
import 'package:weather_app/presentation/themes/themes.dart';

import 'common/values/labels.dart';

class MainApplication extends StatefulWidget {
  @override
  _MainApplicationState createState() => _MainApplicationState();
}

class _MainApplicationState extends State<MainApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Labels.i.appTitle,
      theme: Themes.i.theme,
      initialRoute: Routing.i.initialRoute,
      onGenerateRoute: Routing.i.handle,
      navigatorKey: Routing.i.navigatorKey,
    );
  }
}
