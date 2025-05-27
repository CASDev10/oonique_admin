import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class DashBoardInfoCard {
  final String? svgSrc, title;

  final Color? color;

  DashBoardInfoCard({this.svgSrc, this.title, this.color});
}

List dashboardMainCards = [
  DashBoardInfoCard(
    title: "Support",
    svgSrc: Assets.svgIcCalendar,
    color: Colors.teal,
  ),
  DashBoardInfoCard(
    title: "Banners",
    svgSrc: Assets.svgIcPlans,
    color: Colors.indigo,
  ),
];
