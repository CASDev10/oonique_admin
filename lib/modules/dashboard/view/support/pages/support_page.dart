import 'package:flutter/material.dart';
import 'package:oonique/modules/dashboard/view/support/pages/support_page_desktop.dart';
import 'package:oonique/modules/dashboard/view/support/pages/support_page_mobile.dart';

import '../../../../../responsive.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: SupportPageMobile(size: size),
      desktop: SupportPageDesktop(size: size),
      tablet: SupportPageDesktop(size: size),
    );
  }
}
