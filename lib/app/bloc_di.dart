import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main/screens/support/repository/support_repository.dart';

import '../core/core.dart';
import '../modules/main/cibut/main_cubit.dart';
import '../modules/main/cibut/sidebar_cubit.dart';
import '../modules/main/screens/banners/cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import '../modules/main/screens/banners/repositories/repo.dart';
import '../modules/main/screens/support/cubits/support_cubits.dart';
import '../modules/startup/startup_cubit.dart';
import 'app_cubit.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => AddUpdateBannerCubit(
                bannersRepository: sl<BannersRepository>(),
              ),
        ),
        BlocProvider(
          create:
              (context) => SupportsTicketCubit(
                supportRepository: sl<SupportRepository>(),
              ),
        ),
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
