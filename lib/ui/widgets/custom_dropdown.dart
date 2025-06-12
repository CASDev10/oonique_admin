import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oonique/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final bool disable;
  final Color borderColor;
  final Color hintColor;
  final bool isOutline;
  final String? suffixIconPath;
  final double allPadding;
  final double verticalPadding;
  final double horizontalPadding;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function(String value)? onSelect;
  final double height;

  const CustomDropDown({
    Key? key,
    required this.hint,
    required this.items,
    this.height = 50,
    this.hintColor = AppColors.grey1,
    this.suffixIconPath,
    this.disable = false,
    this.borderColor = AppColors.borderColor,
    this.fontSize = 16,
    this.onSelect,
    this.isOutline = true,
    this.allPadding = 10,
    this.fontWeight = FontWeight.w400,
    this.horizontalPadding = 16,
    this.verticalPadding = 12,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      isDense: true,
      icon: SvgPicture.asset('assets/images/svg/ic_drop_down.svg'),
      style: TextStyle(
        color: AppColors.titlaTextColor, // Set your desired text color here
      ),
      hint: Text(
        widget.hint,
        style: context.textTheme.bodyMedium?.copyWith(color:  AppColors.titlaTextColor),
        overflow: TextOverflow.ellipsis,
      ),
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: widget.fontSize,
          color: AppColors.primaryRed,
          fontWeight: widget.fontWeight,
        ),
        enabled: true,
        filled: true,
        fillColor: AppColors.dialogBgColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:AppColors.borderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color:AppColors.borderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.borderColor, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding,
          vertical: widget.verticalPadding,
        ),
      ),
      dropdownColor:AppColors.dialogBgColor,
      value: dropdownValue,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      onChanged: (String? newValue) {
        if (widget.onSelect != null) {
          widget.onSelect!(newValue!);
        }
        setState(() {
          dropdownValue = newValue!;
        });
      },
      menuMaxHeight: 550,
      items:
          widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                overflow: TextOverflow.ellipsis,
                value,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color:  AppColors.titlaTextColor
                ),
              ),
            );
          }).toList(),
    );
  }
}
