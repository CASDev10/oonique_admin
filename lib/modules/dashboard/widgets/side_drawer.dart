import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oonique/utils/utils.dart';

import '../../../constants/app_colors.dart';
import '../../../generated/assets.dart';
import '../../../ui/widgets/on_click.dart';
import '../../../utils/heights_and_widths.dart';

class SideDrawer extends StatelessWidget {
  final Function(String) onItemSelected;
  final VoidCallback isOpen;
  final String selectedScreen;
  final bool isDrawerOpen;

  SideDrawer(
      {super.key,
      required this.onItemSelected,
      required this.selectedScreen,
      required this.isOpen,
      required this.isDrawerOpen});

  final List<Map<String, dynamic>> menuItems = [
    {"title": "Home", "icon": 'assets/icons/ic_home.svg'},
    {"title": "Banners", "icon": 'assets/icons/ic_plans.svg'},
    {"title": "Support", "icon": 'assets/icons/ic_contact_us.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        backgroundColor: AppColors.bgColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: isDrawerOpen ? 15 : 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isDrawerOpen)
                        // Image.asset(Assets.pngOoniqueLogo,height: 40,width: 40,),
                        Text(
                          'Oonique',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: AppColors.white,
                          ),
                        ),
                      Spacer(),
                      OnClick(
                          onTap: isOpen,
                          child: const Icon(Icons.menu, color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.borderColor,
              thickness: 1,
              height: 1,
            ),
            h2,
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  bool isSelected = menuItems[index]["title"] == selectedScreen;
                  String currentTitle = menuItems[index]["title"];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: isDrawerOpen ? 10 : 0),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.transparent,
                        ),
                        child: InkWell(
                          onTap: () {
                            onItemSelected(currentTitle);
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: isDrawerOpen
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  menuItems[index]["icon"],
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.white,
                                  height: 20,
                                ),
                                if (isDrawerOpen) ...[
                                  const SizedBox(width: 12),
                                  Text(
                                    currentTitle,
                                    style:
                                        context.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.white,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Divider(
              color: AppColors.borderColor,
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 17.0, horizontal: 8),
              child: Row(
                mainAxisAlignment: !isDrawerOpen
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: AppColors.primaryColor, shape: BoxShape.circle),
                    child: Text(
                      'A',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  w1,
                  if (isDrawerOpen)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin User',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          'Administrator',
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
