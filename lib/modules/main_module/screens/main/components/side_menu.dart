import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../../../../constants/routes.dart';
import '../../../../../generated/assets.dart';
import '../../../../../responsive.dart';
import '../../../../dashboard/view/banner/cibut/sidebar_cubit.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDeskTop = Responsive.isDesktop(context);
    // var sidebarCubit = context.read<SideBarCubit>();
    return BlocBuilder<SideBarCubit, SideBarState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: context.colorScheme.background,
          child: ListView(
            children: [
              DrawerHeader(child: Image.asset(Assets.pngOoniqueLogo)),
              DrawerListTile(
                title: "Home",
                svgSrc: "assets/icons/ic_home.svg",
                press: () {
                  // sidebarCubit.setSideBarItem(0);
                  GoRouter.of(context).go(Routes.home);
                  if (!isDeskTop) {
                    Navigator.pop(context);
                  }
                },
                isSelected: state.index == 0,
              ),
              DrawerListTile(
                title: "Banners",
                svgSrc: "assets/icons/ic_plans.svg",
                isSelected: state.index == 2,
                press: () {
                  // sidebarCubit.setSideBarItem(4);

                  GoRouter.of(context).go(Routes.banners);
                  if (!isDeskTop) {
                    Navigator.pop(context);
                  }
                },
              ),
              DrawerListTile(
                title: "Support",
                svgSrc: "assets/icons/ic_contact_us.svg",
                isSelected: state.index == 1,
                press: () {
                  // sidebarCubit.setSideBarItem(4);

                  GoRouter.of(context).go(Routes.support);
                  if (!isDeskTop) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
    this.isSelected = false,
  });

  final String title, svgSrc;
  final VoidCallback press;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      hoverColor: Colors.lightBlue.withOpacity(.4),
      onTap: press,
      selected: isSelected,
      selectedTileColor: context.colorScheme.primary,
      horizontalTitleGap: 8.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
        height: 20,
      ),
      title: Text(
        title,
        style: TextStyle(color: context.colorScheme.onSecondaryContainer),
      ),
    );
  }
}
