import 'package:weather_app/core/factories/factory.dart';

abstract class Navigation {
  Future<dynamic> navigateTo(String routeName, {Object arg});

  Future<dynamic> closeAndNavigateTo(String routeName, {Object arg});

  Future<dynamic> clearAndNavigateTo(String routeName, {Object arg});

  Future<dynamic> switchTo(String routeName, {Object arg});

  void close({bool untilHome, Object arg});

  static Navigation get i => Factory.get<Navigation>();
}
