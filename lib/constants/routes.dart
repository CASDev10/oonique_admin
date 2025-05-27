import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/widgets/not_found_page.dart';

class Routes {
  static const root = '/';
  static const login = 'login';
  static const home = '/dashboard/home';
  static const support = '/dashboard/support';
  static const banners = '/dashboard/banners';

  //static profileNamedPage([String? name]) => '/${name ?? ':profile'}';
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();
}
