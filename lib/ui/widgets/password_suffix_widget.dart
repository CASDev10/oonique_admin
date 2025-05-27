import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class PasswordSuffixIcon extends StatelessWidget {
  const PasswordSuffixIcon({Key? key, required this.isPasswordVisible, required this.onTap}) : super(key: key);
  final bool isPasswordVisible;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      splashRadius: 20,
      icon: Icon(
        isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: AppColors.grey,
        size: 24,
      ),
    );
  }
}