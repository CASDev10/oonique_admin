import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../generated/assets.dart';
import 'startup_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartupCubit(dioClient: sl())..init(),
      child: BlocListener<StartupCubit, StartupState>(
        listener: (context, state) {
          if (state.status == Status.authenticated) {
            GoRouter.of(context).go('/dashboard/home');
          } else if (state.status == Status.unauthenticated) {
            GoRouter.of(context).go('/login');
            // GoRouter.of(context).go('/dashboard/banners');
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56.0),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(Assets.pngOoniqueLogo, scale: 1.4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
