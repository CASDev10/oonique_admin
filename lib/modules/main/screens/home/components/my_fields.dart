import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants.dart';
import '../../../../../constants/routes.dart';
import '../../../../../responsive.dart';
import '../../../cibut/sidebar_cubit.dart';
import '../../../my_files.dart';
import 'file_info_card.dart';

class DashBoardCategories extends StatelessWidget {
  const DashBoardCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: DashboardInfoCardGridView(
        crossAxisCount: size.width < 650 ? 2 : 4,
        childAspectRatio: size.width < 650 && size.width > 350 ? 1.3 : 1,
      ),
      tablet: const DashboardInfoCardGridView(),
      desktop: DashboardInfoCardGridView(
        childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
      ),
    );
  }
}

class DashboardInfoCardGridView extends StatelessWidget {
  const DashboardInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    var sidebarCubit = context.read<SideBarCubit>();
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dashboardMainCards.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder:
          (context, index) => DashboardInfoCard(
            info: dashboardMainCards[index],
            onTap: () {
              // sidebarCubit.setSideBarItem(index);

              if (index == 0) {
                GoRouter.of(context).go(Routes.support);
              }
              if (index == 1) {
                GoRouter.of(context).go(Routes.banners);
              }
            },
          ),
    );
  }
}
