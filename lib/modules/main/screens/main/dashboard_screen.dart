import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/modules/main/screens/banners/pages/banners_page.dart';
import 'package:oonique/modules/main/screens/support/pages/support_page.dart';

import '../../../../app/page_not_found.dart';
import '../../../../config/routes/nav_router.dart';
import '../../../../constants/routes.dart';
import '../../../../responsive.dart';
import '../../../../ui/widgets/loading_indicator.dart';
import '../../../startup/startup_cubit.dart';
import '../../cibut/main_cubit.dart';
import '../../cibut/sidebar_cubit.dart';
import '../home/home_screen.dart';
import 'components/side_menu.dart';

class DashboardScreen extends StatefulWidget {
  final String selectedChild;

  const DashboardScreen({super.key, required this.selectedChild});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Widget getScreen(String path, SideBarCubit sidebarCubit) {
    switch (path) {
      case 'home':
        sidebarCubit.setSideBarItem(0);
        return const HomeScreen();

      case 'support':
        sidebarCubit.setSideBarItem(1);
        return const SupportPage();

      case 'banners':
        sidebarCubit.setSideBarItem(2);
        return const BannersPage();
      //
      // case 'services':
      //   sidebarCubit.setSideBarItem(3);
      //   return const ServicesPage();
      //
      // case 'packages':
      //   sidebarCubit.setSideBarItem(4);
      //   return const PackagesPage();
      // case 'contactUs':
      //   sidebarCubit.setSideBarItem(5);
      //   return const ContactUsPage();
      default:
        return const PageNotFound();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<StartupCubit>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    var sidebarCubit = context.read<SideBarCubit>();

    return BlocConsumer<StartupCubit, StartupState>(
      listener: (context, startUpState) async {
        if (startUpState.status == Status.unauthenticated) {
          NavRouter.pushAndRemoveUntil(context, '/${Routes.login}');
        }
      },
      builder: (context, startUpState) {
        return startUpState.status == Status.none
            ? const LoadingIndicator()
            : BlocBuilder<SideBarCubit, SideBarState>(
              builder: (context, state) {
                return Scaffold(
                  key: context.read<MainCubit>().scaffoldKey,
                  drawer: const SideMenu(),
                  body: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // We want this side menu only for large screen
                        if (Responsive.isDesktop(context))
                          const Expanded(
                            // default flex = 1
                            // and it takes 1/6 part of the screen
                            child: SideMenu(),
                          ),
                        Expanded(
                          // It takes 5/6 part of the screen
                          flex: 5,
                          child: getScreen(widget.selectedChild, sidebarCubit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
      },
    );
  }
}
