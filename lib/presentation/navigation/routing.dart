import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/factories/factory.dart';
import 'package:weather_app/presentation/navigation/routes.dart';
import 'package:weather_app/presentation/pages/hello_world.dart';
import 'package:weather_app/presentation/pages/home.dart';
import 'package:weather_app/presentation/pages/page_not_found.dart';
import 'package:weather_app/presentation/pages/weather.dart';

class Routing {
  String get initialRoute => initial_route;
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Route<dynamic> handle(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case routes_initial:
        return CupertinoPageRoute(builder: (_) => HomePage());
      case routes_hello_world:
        return CupertinoPageRoute(builder: (_) => HelloWorldPage());
      case routes_weather:
        return CupertinoPageRoute(builder: (_) => WeatherPage());

      default:
        return _errorRoute(settings?.name);
    }
  }

  Route<dynamic> _errorRoute(String path) {
    return MaterialPageRoute(builder: (_) {
      return PageNotFound(path: path);
    });
  }

  static Routing get i => Factory.get<Routing>();
}
