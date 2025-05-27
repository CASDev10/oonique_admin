import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../utils/validators/validators.dart';

class TextFieldWithOutBorder extends StatefulWidget {
  final double vMargin;
  final double hMargin;
  final double borderRadius;
  final FontWeight fontWeight;
  final double fontSize;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final VoidCallback? onSuffixTapped;
  final Widget? suffixIcon;
  final Color fillColor;
  final Color hintColor;
  final Color textColor;
  final bool readOnly ;
  final int maxLines ;
  final FormFieldValidator<String>? validator;

  const TextFieldWithOutBorder({
    super.key,
    this.controller,
    required this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.textInputAction,
    this.vMargin = 0,
    this.hMargin = 0,
    this.borderRadius = 5.0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.style,
    this.hintText,
    this.hintStyle,
    this.focusNode,
    this.suffixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.onSuffixTapped,
    this.fillColor = const Color(0xFFEBEBEB),
    this.hintColor = AppColors.grey1,
    this.textColor = AppColors.black,
    this.validator,
  });

  @override
  State<TextFieldWithOutBorder> createState() => _TextFieldWithOutBorderState();
}

class _TextFieldWithOutBorderState extends State<TextFieldWithOutBorder> {
  @override
  Widget build(BuildContext context) {
    final validator =
        widget.validator ?? Validators.getValidator(widget.keyboardType);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.vMargin, horizontal: widget.hMargin),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: validator,
        maxLines: widget.maxLines,
        readOnly: widget.readOnly,
        textInputAction: widget.textInputAction,
        keyboardType: widget.keyboardType,
        style: TextStyle(
            color: widget.textColor,
            fontWeight: widget.fontWeight,
            fontSize: widget.fontSize),
        onChanged: widget.onChanged,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
                color: widget.hintColor,
                fontWeight: widget.fontWeight,
                fontSize: widget.fontSize),
            fillColor: widget.fillColor,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            suffixIcon: widget.suffixIcon != null
                ? widget.suffixIcon
                : widget.onSuffixTapped != null
                ? IconButton(
              icon: Icon(
                widget.obscureText
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: widget.onSuffixTapped,
            )
                : SizedBox.shrink()),
      ),
    );
  }
}
