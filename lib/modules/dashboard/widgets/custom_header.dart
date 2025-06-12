import 'package:flutter/material.dart';
import 'package:oonique/utils/utils.dart';

import '../../../constants/app_colors.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final String selectedScreen;
  final String subtitle;

  const DrawerHeaderWidget({
    Key? key,
    required this.selectedScreen,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration:  BoxDecoration(
        color: AppColors.bgColor,
        border: Border(
          bottom: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16), // Optional left padding
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                selectedScreen,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              Text(
                subtitle,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.titlaTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
