import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/dashboard/view/support/repository/support_repository.dart';

import '../core/core.dart';
import '../modules/dashboard/repo/repo.dart';
import '../modules/dashboard/view/banner/cubit/add_update_banner_cubit/add_update_banner_cubit.dart';
import '../modules/dashboard/view/banner/cubit/banner_ads_cubit.dart';
import '../modules/dashboard/view/support/cubits/support_cubits.dart';
import '../modules/dashboard/view/support/cubits/update_ticket/update_ticket_cubit.dart';
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
          create: (context) => AddUpdateBannerCubit(
            bannersRepository: sl<BannersRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SupportsTicketCubit(
            supportRepository: sl<SupportRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              UpdateTicketCubit(supportRepository: sl<SupportRepository>()),
        ),
        BlocProvider<AppCubit>(create: (context) => AppCubit(sl())..init()),
        BlocProvider<StartupCubit>(
          create: (context) => StartupCubit(dioClient: sl()),
        ),
        BlocProvider(
            create: (context) =>
                BannerAdsCubit(bannersRepository: sl<BannersRepository>())),
        BlocProvider(
          create: (context) =>
              SupportsTicketCubit(supportRepository: sl<SupportRepository>()),
        )
      ],
      child: child,
    );
  }
}
