import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // BuildContext dialogContext;

  Future<dynamic> pushNamedTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamedTo(String routeName,
      {Object? arguments}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  ///pushNamedAndRemoveUntil and add destination to stack after clearing it
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void goBack() {
    navigatorKey.currentState!.pop();
  }
}
