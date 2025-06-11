
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oonique/utils/utils.dart';

import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';
import '../../utils/validators/validators.dart';
import '../widgets/password_suffix_widget.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    required this.controller,
    required this.label,
    this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.suffix,
    this.focusBorderColor,
    this.prefixIcon,
    this.maxLines = 1,
    this.fillColor = Colors.white,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.autoFocus = false,
    super.key,
    this.onChange,
    this.borderColor,
    this.borderRadius = 6,
    this.fontSize = 14,
    this.boxConstraints = 44,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding = 20,
    this.verticalPadding = 14,
    this.suffixIconTopPadding = 16,
    this.suffixIconRightPadding = 25,
    this.labelColor = Colors.black,
    this.hintColor = Colors.grey,
    this.lMargin = 18,
    this.rMargin = 8,
    this.textColor,
    this.fieldTitle = "",
    this.titleSize = 16.0,
    this.titleWeight,
    this.focusNode,
  });

  final String? fieldTitle;
  final TextEditingController controller;
  final String label;
  final TextInputAction? textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autoFocus;
  final Function(String)? onChange;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? textColor;
  final double borderRadius;
  final double? titleSize;
  final double horizontalPadding;
  final double verticalPadding;
  final double fontSize;
  final double boxConstraints;
  final double suffixIconTopPadding;
  final double suffixIconRightPadding;
  final FontWeight fontWeight;
  final Color labelColor;
  final Color hintColor;
  final double lMargin;
  final FontWeight? titleWeight;
  final double rMargin;
  final FocusNode? focusNode;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    final validator =
        widget.validator ?? Validators.getValidator(widget.keyboardType);

    return Column(
      children: [
        widget.fieldTitle != ""
            ? Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    widget.fieldTitle!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: widget.titleSize ?? 16.0,
                      fontWeight: widget.titleWeight ?? FontWeight.w500,
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        Stack(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(
                  color: widget.textColor ?? Colors.black, fontSize: 13),
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: widget.obscureText,
              validator: validator,
              enabled: true,
              onTap: widget.onTap,
              autofocus: widget.autoFocus,
              readOnly: widget.readOnly,
              inputFormatters: widget.inputFormatters,
              onFieldSubmitted: widget.onFieldSubmitted,
              maxLines: widget.maxLines,
              onChanged: widget.onChange,
              cursorColor: AppColors.textGrey,
              decoration: InputDecoration(
                hintText: widget.label,
                labelStyle: TextStyle(
                    color: widget.labelColor,
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                    fontFamily: AssetPaths.aileronFont),
                hintStyle: TextStyle(
                    color: widget.hintColor,
                    fontSize: widget.fontSize,
                    fontWeight: widget.fontWeight,
                    fontFamily: AssetPaths.aileronFont),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: widget.borderColor ?? Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: BorderSide(
                    color: widget.focusBorderColor ?? Colors.transparent,
                  ),
                ),
                errorStyle: const TextStyle(
                  color: AppColors.red,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide: const BorderSide(
                    color: AppColors.red,
                  ),
                ),
                filled: true,
                fillColor: widget.fillColor,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                  vertical: widget.verticalPadding,
                ),
                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: BoxConstraints(
                  maxWidth: widget.boxConstraints,
                  maxHeight: widget.boxConstraints,
                ),
                suffix: widget.suffix,
              ),
            ),
            Positioned(
              right: widget.suffixIcon is IconButton ||
                      widget.suffixIcon is PasswordSuffixIcon
                  ? 6
                  : widget.suffixIconRightPadding,
              top: widget.suffixIcon is IconButton ||
                      widget.suffixIcon is PasswordSuffixIcon
                  ? 0
                  : widget.suffixIconTopPadding,
              child: Align(
                alignment: Alignment.center,
                child: widget.suffixIcon,
              ),
            )
          ],
        ),
      ],
    );
  }
}
