import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oonique/constants/app_colors.dart';
import 'package:oonique/utils/extensions/extended_context.dart';
import 'package:oonique/utils/heights_and_widths.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.count,
      required this.isProfit});

  final String title, iconPath, count;
  final bool isProfit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        12.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          color: AppColors.bgColor,
          border: Border.all(color: AppColors.borderColor)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColors.titlaTextColor),
                  ),
                ),
                h1,
                Text(
                  count,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontSize: 21.0,
                  ),
                ),
                h1,
                // Row(
                //   children: [
                //     Row(
                //       children: [
                //         Icon(
                //           isProfit ? Icons.arrow_upward : Icons.arrow_downward,
                //           color: isProfit
                //               ? const Color(0xff22c55e)
                //               : const Color(0xffef4444),
                //           size: 13,
                //         ),
                //         Text(
                //           "14%",
                //           style: context.textTheme.bodyMedium?.copyWith(
                //             fontSize: 12,
                //             fontWeight: FontWeight.w400,
                //             color: isProfit
                //                 ? const Color(0xff22c55e)
                //                 : const Color(0xffef4444),
                //           ),
                //         ),
                //       ],
                //     ),
                //     w0P5,
                //     const Text(
                //       "from last week",
                //       style: TextStyle(
                //         fontSize: 11,
                //         color: AppColors.titlaTextColor,
                //         fontWeight: FontWeight.w400,
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
          Container(
            height: 45.0,
            width: 45.0,
            decoration: BoxDecoration(
              color: AppColors.borderColor,
              borderRadius: BorderRadius.circular(
                100.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(
                iconPath,
                height: 20,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

BoxDecoration customBoxDecoration(
    {BorderRadiusGeometry? borderAt,
    Color? shadowColor,
    Color? color,
    Color? borderColor,
    Gradient? gradient,
    double? radius,
    double? borderWidth,
    bool? shadow = false}) {
  return BoxDecoration(
    gradient: gradient,
    color: color ?? Colors.white,
    border: Border.all(
      color: borderColor ?? Colors.transparent,
      width: borderWidth ?? 1.0,
    ),
    borderRadius: borderAt ??
        BorderRadius.circular(
          radius ?? 12.0,
        ),
    boxShadow: [
      if (shadow! == true)
        BoxShadow(
          color: shadowColor ?? Colors.grey,
          blurRadius: 8.5,
          spreadRadius: 1.5,
        )
    ],
  );
}
