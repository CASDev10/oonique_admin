import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';
import '../../utils/validators/validators.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.label,
    required this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.autoFocus = false,
    super.key,
    this.onChange,
    this.fillColor = AppColors.white,
    this.hintColor = AppColors.grey1,
  });

  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autoFocus;
  final Function(String)? onChange;
  final Color fillColor;
  final Color hintColor;

  InputField.name({
    required TextEditingController controller,
    required String label,
    Function(String)? onChange,
    String? Function(String? value)? validator,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    Widget? suffixIcon,
    Widget? prefixIcon,
    TextInputType keyboardType = TextInputType.name,
  }) : this(
         controller: controller,
         label: label,
         textInputAction: textInputAction,
         keyboardType: keyboardType,
         validator: validator,
         onFieldSubmitted: onFieldSubmitted,
         suffixIcon: suffixIcon,
         prefixIcon: suffixIcon,
         onChange: onChange,
       );

  InputField.phone({
    required TextEditingController controller,
    required String label,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    final Function(String)? onChange,
    String? Function(String? value)? validator,
  }) : this(
         controller: controller,
         label: label,
         textInputAction: textInputAction,
         keyboardType: TextInputType.phone,
         validator: validator,
         onChange: onChange,
         onFieldSubmitted: onFieldSubmitted,
         inputFormatters: inputFormatters,
       );

  InputField.email({
    required TextEditingController controller,
    required String label,
    Function(String)? onChange,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    Widget? suffixIcon,
    String? Function(String? value)? validator,
  }) : this(
         controller: controller,
         label: label,
         textInputAction: textInputAction,
         keyboardType: TextInputType.emailAddress,
         validator: validator ?? Validators.email,
         onFieldSubmitted: onFieldSubmitted,
         suffixIcon: suffixIcon,
         onChange: onChange,
       );

  InputField.password({
    required TextEditingController controller,
    required Widget suffixIcon,
    required bool obscureText,
    required String label,
    required String? validator(String? value)?,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
  }) : this(
         controller: controller,
         label: label,
         textInputAction: textInputAction,
         keyboardType: TextInputType.visiblePassword,
         validator: validator,
         onFieldSubmitted: onFieldSubmitted,
         obscureText: obscureText,
         suffixIcon: suffixIcon,
       );

  InputField.confirmPassword({
    required TextEditingController controller,
    required TextEditingController confirmPasswordController,
    required Widget suffixIcon,
    required bool obscureText,
    required ValueChanged<String>? onFieldSubmitted,
    required String label,
    TextInputAction textInputAction = TextInputAction.done,
    Key? key,
  }) : this(
         key: key,
         controller: controller,
         label: label,
         textInputAction: textInputAction,
         keyboardType: TextInputType.visiblePassword,
         validator: (String? value) {
           if (value == null || value.isEmpty) {
             return "Required";
           }
           if (value != confirmPasswordController.text) {
             return "Password Not Match";
           }
           return null;
         },
         onFieldSubmitted: onFieldSubmitted,
         obscureText: obscureText,
         suffixIcon: suffixIcon,
       );

  InputField.number({
    required TextEditingController controller,
    required String label,
    TextInputAction textInputAction = TextInputAction.next,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String? value)? validator,
    ValueChanged<String>? onFieldSubmitted,
    Widget? prefixIcon,
  }) : this(
         controller: controller,
         label: label,
         textInputAction: textInputAction,
         keyboardType: TextInputType.number,
         validator: validator,
         onFieldSubmitted: onFieldSubmitted,
         prefixIcon: prefixIcon,
         inputFormatters:
             inputFormatters ?? [FilteringTextInputFormatter.digitsOnly],
       );

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    final validator =
        widget.validator ?? Validators.getValidator(widget.keyboardType);

    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
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
          style: TextStyle(
            color: Colors.black, // Set your desired text color here
          ),
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: context.textTheme.bodyMedium?.copyWith(
              color: widget.hintColor,
            ),
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            contentPadding: EdgeInsets.all(16),
          ),
        ),
        // Positioned(
        //   right: widget.suffixIcon is IconButton ||
        //           widget.suffixIcon is PasswordSuffixIcon
        //       ? 0
        //       : 10,
        //   top: widget.suffixIcon is IconButton ||
        //           widget.suffixIcon is PasswordSuffixIcon
        //       ? 0
        //       : 16,
        //   child: Align(
        //     alignment: Alignment.centerRight,
        //     child: widget.suffixIcon,
        //   ),
        // )
      ],
    );
  }
}
