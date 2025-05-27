import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/core.dart';
import '../modules/main/cibut/main_cubit.dart';
import '../modules/main/cibut/sidebar_cubit.dart';
import '../modules/startup/startup_cubit.dart';
import 'app_cubit.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) => AppCubit(sl())..init()),
        BlocProvider<SideBarCubit>(create: (context) => SideBarCubit()),
        BlocProvider<MainCubit>(create: (context) => MainCubit()),
        BlocProvider<StartupCubit>(
          create: (context) => StartupCubit(dioClient: sl()),
        ),
      ],
      child: child,
    );
  }
}
