import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/dashboard/view/base_view.dart';
import 'package:sizer/sizer.dart';

import '../config/config.dart';
import '../config/routes/app_routes.dart';
import '../modules/authentication/login/screens/login_page.dart';
import '../modules/authentication/login/screens/login_screen.dart';
import '../ui/widgets/unfocus.dart';
import 'app_cubit.dart';
import 'bloc_di.dart';

class OoniqueApp extends StatelessWidget {
  const OoniqueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocDI(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Sizer(builder: (context, orientation, deviceType) {
            return MaterialApp(
              title: 'Oonique Admin',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              builder: (BuildContext context, Widget? child) {
                child = BotToastInit()(context, child);
                child = UnFocus(child: child);
                return child;
              },
              // routeInformationProvider:
              //     AppRouter.router.routeInformationProvider,
              // routeInformationParser: AppRouter.router.routeInformationParser,
              // routerDelegate: AppRouter.router.routerDelegate,
          home: LoginPage(),
            );
          });
        },
      ),
    );
  }
}
