import 'package:flutter/material.dart';

import '../../../../responsive.dart';
import 'login_page.dart';
import 'login_mobile.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Responsive(
      mobile: const LoginMobilePage(),
      desktop: LoginPage(),
      tablet: LoginPage(),
    );
  }
}
