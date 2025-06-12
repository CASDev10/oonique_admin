import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/authentication/login/screens/login_screen.dart';
import '../../modules/main_module/screens/main/dashboard_screen.dart';
import '../../modules/startup/splash_page.dart';
import '../../ui/widgets/not_found_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    observers: [BotToastNavigatorObserver()],
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: '/dashboard/:child',
        builder: (context, state) {
          final child = state.pathParameters['child']!;
          return DashboardScreen(selectedChild: child);
        },
      ),
      GoRoute(
        path: '/:path*',
        builder: (context, state) {
          return const NotFoundScreen();
        },
      ),
    ],
  );
  static GoRouter get router => _router;
}
