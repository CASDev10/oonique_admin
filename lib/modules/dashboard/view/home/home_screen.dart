import 'package:flutter/material.dart';
import 'package:oonique/constants/app_colors.dart';

import '../../../../utils/heights_and_widths.dart';
import 'widget/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              const Expanded(
                  child: HomeHeader(
                title: 'Banners',
                iconPath: 'assets/icons/ic_plans.svg',
                count: '125,663',
                isProfit: true,
              )),
              w1,
              const Expanded(
                  child: HomeHeader(
                title: 'Support',
                iconPath: 'assets/icons/ic_contact_us.svg',
                count: '256',
                isProfit: false,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
