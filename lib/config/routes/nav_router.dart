import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavRouter {
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();

  static Future push(
    BuildContext context,
    Widget route, {
    bool bottomToTop = false,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(fullscreenDialog: bottomToTop, builder: (_) => route),
    );
  }

  static Future<dynamic> to(Widget page, {arguments}) async =>
      navigationKey.currentState?.push(MaterialPageRoute(
        builder: (_) => page,
      ));
  static Future<dynamic> toReplacement(Widget page, {arguments}) async =>
      navigationKey.currentState?.pushReplacement(MaterialPageRoute(
        builder: (_) => page,
      ));

  /// Push Replacement
  static Future pushReplacement(
    BuildContext context,
    Widget route, {
    bool bottomToTop = false,
  }) {
    return Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            fullscreenDialog: bottomToTop, builder: (context) => route));
  }

  /// Pop
  static void pop(BuildContext context, [result]) {
    return Navigator.of(context).pop(result);
  }

  /// Push and remove until
  static void pushAndRemoveUntil(BuildContext context, String location) {
    clearAndNavigate(context, location);
  }

  static void clearAndNavigate(BuildContext context, String path) {
    while (context.canPop() == true) {
      context.pop();
    }
    context.go(path);
  }

  /// Push and remove until
  static Future pushAndRemoveUntilFirst(BuildContext context, Widget route) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => route,
        ),
        (Route<dynamic> route) => route.isFirst);
  }
}
