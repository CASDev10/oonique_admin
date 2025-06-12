import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oonique/utils/utils.dart';

import '../../constants/app_colors.dart';
import '../../utils/heights_and_widths.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.hMargin = 16,
      this.vMargin = 10,
      this.height = 25,
      this.width = double.infinity,
      this.backgroundColor = Colors.black,
      this.titleColor = Colors.white,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 16,
      this.fontWidget,
      this.borderRadius = 6,
      this.buttonVerticalPadding = 0,
      this.shadowColor,
      this.bborderColor,
      this.elevation});

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double vMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? bborderColor;
  final Color? shadowColor;
  final double borderRadius;
  final double buttonVerticalPadding;
  final FontWeight fontWeight;
  final double? fontSize;
  final double? elevation;
  final Widget? fontWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: vMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation ?? 12.0,
          shadowColor: shadowColor ?? Colors.black,
          padding: EdgeInsets.symmetric(
              horizontal: 12, vertical: buttonVerticalPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: bborderColor ?? AppColors.transparent)),
          backgroundColor: backgroundColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: titleColor ?? Colors.white,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryOutlineButton extends StatelessWidget {
  const PrimaryOutlineButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.hMargin = 0,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor,
    this.titleColor = AppColors.white,
    this.borderColor = Colors.grey,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16.0,
    this.fontWidget,
    this.borderRadius = 8,
    this.borderWidth = 1.5,
    this.gradientColors, // New property for gradient border
  });

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
  final double fontSize;
  final double? borderWidth;
  final Widget? fontWidget;
  final List<Color>? gradientColors; // Gradient color list

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: gradientColors ?? [borderColor, borderColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWidth ?? 2), // Border thickness
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.surface,
            borderRadius: BorderRadius.circular(borderRadius - 1),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius - 1),
              ),
              backgroundColor:
                  Colors.transparent, // Transparent for inner Container
              shadowColor: Colors.transparent, // Remove shadows
            ),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: fontWeight,
                  color: titleColor,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrefixIconButton extends StatelessWidget {
  const PrefixIconButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.height = 44,
      this.backgroundColor = Colors.white,
      this.titleColor = Colors.white,
      this.fontSize = 13,
      this.prefixIconPath,
      this.hPadding = 12,
      this.borderColor,
      this.prefixIconSize = 16,
      this.borderRadius = 6,
      this.foregroundColor,
      this.width,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.titleGap = 14});

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final double height;
  final double? width;
  final Color backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final String? prefixIconPath;
  final double prefixIconSize;
  final double hPadding;
  final Color titleColor;
  final MainAxisAlignment mainAxisAlignment;
  final Color? borderColor;
  final double titleGap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                  color: borderColor != null
                      ? borderColor!
                      : context.colorScheme.outline,
                  width: .5)),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              height: prefixIconSize,
              prefixIconPath!,
            ),
            SizedBox(
              width: titleGap,
            ),
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize,
                  color: titleColor),
            )
          ],
        ),
      ),
    );
  }
}

class SuffixIconButton extends StatelessWidget {
  const SuffixIconButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.height = 44,
      this.backgroundColor = Colors.white,
      this.titleColor = Colors.white,
      this.borderColor,
      this.foregroundColor,
      this.fontSize = 16,
      this.suffixIconSize = 18,
      this.hPadding = 12,
      this.suffixIconPath,
      this.borderRadius = 10,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.titleGap = 14});

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final double height;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color titleColor;
  final double borderRadius;
  final double suffixIconSize;
  final double hPadding;
  final String? suffixIconPath;
  final MainAxisAlignment mainAxisAlignment;
  final double titleGap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(
                  color: borderColor != null
                      ? borderColor!
                      : context.colorScheme.outline,
                  width: .5)),
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Text(
              title,
              style: context.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                  color: titleColor),
            ),
            SizedBox(
              width: titleGap,
            ),
            SvgPicture.asset(
              height: suffixIconSize,
              suffixIconPath!,
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryIconOutlineButton extends StatelessWidget {
  const PrimaryIconOutlineButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.hMargin = 0,
      this.height = 50,
      this.width = double.infinity,
      this.backgroundColor,
      this.titleColor = AppColors.white,
      this.borderColor = Colors.grey,
      this.fontWeight = FontWeight.w600,
      this.fontSize = 16.0,
      this.fontWidget,
      this.borderRadius = 8,
      this.borderWidth = 1.5,
      this.titleAlignment = Alignment.centerLeft,
      required this.iconSvgPath});

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Alignment? titleAlignment;
  final Color? titleColor;
  final String iconSvgPath;
  final double borderRadius;
  final Color borderColor;
  final FontWeight fontWeight;
  final double fontSize;
  final double? borderWidth;
  final Widget? fontWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor, width: borderWidth!)),
          backgroundColor: backgroundColor ?? context.colorScheme.surface,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: iconSvgPath.isNotEmpty
                      ? SvgPicture.asset(
                          iconSvgPath,
                          height: 24,
                          width: 24,
                          color: titleColor,
                        )
                      : const SizedBox(),
                ),
                w2,
                Expanded(
                  flex: 12,
                  child: Align(
                    alignment: titleAlignment!,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge!.copyWith(
                        fontWeight: fontWeight,
                        color: titleColor,
                        fontSize: fontSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
