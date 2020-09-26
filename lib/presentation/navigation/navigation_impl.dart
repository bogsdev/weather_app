import 'package:flutter/material.dart';
import 'package:weather_app/presentation/navigation/routes.dart';

import 'navigation.dart';

class NavigationImpl implements Navigation {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationImpl(this.navigatorKey);

  Future<dynamic> navigateTo(String routeName, {Object arg}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: arg);
  }

  Future<dynamic> closeAndNavigateTo(String routeName, {Object arg}) {
    close();
    return navigatorKey.currentState.pushNamed(routeName, arguments: arg);
  }

  Future<dynamic> clearAndNavigateTo(String routeName, {Object arg}) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (r) => false, arguments: arg);
  }

  Future<dynamic> switchTo(String routeName, {Object arg}) {
    return navigatorKey.currentState.popAndPushNamed(routeName, arguments: arg);
  }

  void close({bool untilHome, Object arg}) {
    if (navigatorKey.currentState.canPop() == true) {
      if (untilHome == true) {
        navigatorKey.currentState.popUntil((route) {
          if (route.settings.name == initial_route) {
            return true;
          } else {
            return false;
          }
        });
      } else {
        navigatorKey.currentState.pop(arg);
      }
    }
  }
}
