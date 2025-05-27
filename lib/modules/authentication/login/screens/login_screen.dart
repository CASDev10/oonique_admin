import 'package:flutter/material.dart';

import '../../../../responsive.dart';
import 'login_desktop.dart';
import 'login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: const LoginMobilePage(),
      desktop: LoginDesktopPage(size: size),
      tablet: LoginDesktopPage(size: size),
    );
  }
}
