import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.hMargin = 0,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor,
    this.titleColor = AppColors.white,
    this.borderColor = const Color(0xFF44C8F5),
    this.fontWeight = FontWeight.w600,
    this.fontSize,
    this.fontWidget,
    this.borderRadius = 8,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double borderRadius;
  final Color borderColor;
  final FontWeight fontWeight;
  final double? fontSize;
  final Widget? fontWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      child: ElevatedButton(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: fontWeight,
                  color: titleColor,
                  fontSize: fontSize ?? null,
                ),
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: backgroundColor ?? context.colorScheme.primary,
        ),
      ),
    );
  }
}

class PrimaryOutlineButton extends StatelessWidget {
  const PrimaryOutlineButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.hMargin = 0,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor,
    this.titleColor = AppColors.white,
    this.borderColor = const Color(0xFF44C8F5),
    this.fontWeight = FontWeight.w600,
    this.fontSize,
    this.fontWidget,
    this.borderRadius = 8,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double borderRadius;
  final Color borderColor;
  final FontWeight fontWeight;
  final double? fontSize;
  final Widget? fontWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      child: ElevatedButton(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: fontWeight,
                  color: titleColor,
                  fontSize: fontSize ?? null,
                ),
              ),
            ),
          ],
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor),
          ),
          backgroundColor: backgroundColor ?? context.colorScheme.secondary,
        ),
      ),
    );
  }
}

class PrefixIconButton extends StatelessWidget {
  const PrefixIconButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.height = 44,
    this.backgroundColor,
    this.foregroundColor,
    this.fontSize,
    this.prefixIconPath,
    this.borderRadius = 10,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final String? prefixIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: TextButton(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: context.colorScheme.secondary,
                ),
              ),
            ),
            if (prefixIconPath != null)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  height: 18,
                  prefixIconPath!,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colorScheme.secondary),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}

class SuffixIconButton extends StatelessWidget {
  const SuffixIconButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.height = 44,
    this.backgroundColor,
    this.foregroundColor,
    this.fontSize,
    this.suffixIconPath,
    this.borderRadius = 10,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final String? suffixIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: TextButton(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: context.colorScheme.surface,
                ),
              ),
            ),
            if (suffixIconPath != null)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  height: 18,
                  suffixIconPath!,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.surface,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: context.colorScheme.onBackground,
          padding: EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
