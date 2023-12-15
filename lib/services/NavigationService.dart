// Flutter imports:
import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  static Future<dynamic> navigateTo(Route<Object> route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  static Future<dynamic> goTo(Route<Object> route) {
    return navigatorKey.currentState!.push(route);
  }

  static Future<dynamic> goToAndThen(Route<Object> route, Function(Object?) f) {
    return navigatorKey.currentState!.push(route).then(f);
  }

  static void pop() {
    return navigatorKey.currentState!.pop();
  }
}
