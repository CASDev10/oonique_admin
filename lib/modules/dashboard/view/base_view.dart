import 'package:flutter/material.dart';
import 'package:oonique/modules/dashboard/view/banner/view/banner_screen.dart';
import 'package:oonique/modules/dashboard/widgets/custom_header.dart';
import 'package:oonique/modules/dashboard/widgets/side_drawer.dart';

import '../../../constants/app_colors.dart';

class BaseView extends StatefulWidget {
  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  OverlayEntry? _overlayEntry;

  bool isDrawerOpen = true;
  String _selectedScreen = "Home";

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
    });
  }

  void changeScreen(String screen) {
    setState(() {
      _selectedScreen = screen;
    });
  }
late Map<String, Widget> _screens;
  // final Map<String, Widget> _screens = {
  //   "Home": Container(),
  //   "Banners": BannerScreen(size:MediaQuery.of(context).size ,),
  //   "Support": Container(),
  // };

  final Map<String, String> _subtitles = {
    "Home": "Analytics and insights for your platform",
    "Banners": "Manage your platform users",
    "Support": "Review and manage reported content",
  };

  @override
  Widget build(BuildContext context) {
      final Size screenSize = MediaQuery.of(context).size;

    _screens = {
      "Home": Container(),
      "Banners": BannerScreen(size: screenSize),
      "Support": Container(),
    };
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Row(
        children: [
          Container(
            color: Colors.white,
            width: isDrawerOpen ? 250 : 80,
            child: SideDrawer(
                isDrawerOpen: isDrawerOpen,
                isOpen: toggleDrawer,
                onItemSelected: changeScreen,
                selectedScreen: _selectedScreen),
          ),
          Expanded(
            child: Column(
              children: [
                DrawerHeaderWidget(
                  selectedScreen: _selectedScreen,
                  subtitle: _subtitles[_selectedScreen] ?? "",
                ),
                Expanded(
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      child: _screens[_selectedScreen] ??
                          const Text("No Screen Found")),
                )
              ],
            ),
          ),
        ],
      ),
      drawer: SideDrawer(
          isDrawerOpen: isDrawerOpen,
          isOpen: toggleDrawer,
          onItemSelected: changeScreen,
          selectedScreen: _selectedScreen),
    );
  }
}
