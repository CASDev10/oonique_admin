import 'package:flutter/material.dart';
import 'package:oonique/modules/main_module/screens/banners/pages/banner_ads_desktop.dart';
import 'package:oonique/modules/main_module/screens/banners/pages/banner_ads_mobile.dart';

import '../../../../../responsive.dart';

class BannersPage extends StatelessWidget {
  const BannersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: BannerAdsMobile(),
      desktop: BannerAdsDesktop(size: size),
      tablet: BannerAdsDesktop(size: size),
    );
  }
}
