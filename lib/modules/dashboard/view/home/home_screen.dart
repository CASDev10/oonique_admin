import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oonique/constants/app_colors.dart';
import 'package:oonique/modules/dashboard/view/banner/cubit/banner_ads_cubit.dart';
import 'package:oonique/modules/dashboard/view/support/cubits/support_cubits.dart';

import '../../../../utils/heights_and_widths.dart';
import 'widget/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? totalBanners;
  int? totalTickets;

  getValues() async {
    await Future.wait([
      context.read<BannerAdsCubit>().getAllBanners(),
      context.read<SupportsTicketCubit>().getAllTickets()
    ]).then((v) {
      setState(() {
        totalBanners = context.read<BannerAdsCubit>().state.totalItems;
        totalTickets = context.read<SupportsTicketCubit>().state.totalItems;
      });
    });
  }

  @override
  void initState() {
    getValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: BoxDecoration(
        color: AppColors.bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: HomeHeader(
                title: 'Banners',
                iconPath: 'assets/icons/ic_plans.svg',
                count: totalBanners != null ? '$totalBanners' : "0",
                isProfit: true,
              )),
              w1,
              Expanded(
                  child: HomeHeader(
                title: 'Support',
                iconPath: 'assets/icons/ic_contact_us.svg',
                count: totalTickets != null ? '$totalTickets' : "0",
                isProfit: false,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
